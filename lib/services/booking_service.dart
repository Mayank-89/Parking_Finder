
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _bookings =>
      _firestore.collection('bookings');

  // Create a booking before payment.
  Future<String> createBooking({
    required String parkingId,
    required String parkingName,
    required DateTime startTime,
    required DateTime endTime,
    required num amount,
    String? slotNumber,
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('Please log in before booking parking.');
    }

    if (!endTime.isAfter(startTime)) {
      throw Exception('End time must be after start time.');
    }

    if (amount < 0) {
      throw Exception('Booking amount cannot be negative.');
    }

    final doc = _bookings.doc();

    await doc.set({
      'bookingId': doc.id,
      'userId': user.uid,
      'parkingId': parkingId,
      'parkingName': parkingName,
      'slotNumber': slotNumber ?? 'Not assigned',
      'startTime': Timestamp.fromDate(startTime),
      'endTime': Timestamp.fromDate(endTime),
      'amount': amount,
      'status': 'pending_payment',
      'paymentStatus': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });

    return doc.id;
  }

  // Demo only: call after simulated payment success.
  // For production, verify payment on a trusted backend.
  Future<void> markPaymentSuccessful(String bookingId) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('Please log in to update this booking.');
    }

    final ref = _bookings.doc(bookingId);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(ref);
      final data = snapshot.data();

      if (!snapshot.exists || data == null || data['userId'] != user.uid) {
        throw Exception('Booking not found.');
      }

      if (data['status'] != 'pending_payment' ||
          data['paymentStatus'] != 'pending') {
        throw Exception('Booking is not awaiting payment.');
      }

      transaction.update(ref, {
        'status': 'confirmed',
        'paymentStatus': 'paid',
        'paidAt': FieldValue.serverTimestamp(),
      });
    });
  }

  // Listen to the current user's bookings.
  Stream<QuerySnapshot<Map<String, dynamic>>> watchMyBookings() {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('Please log in to view your bookings.');
    }

    return _bookings
        .where('userId', isEqualTo: user.uid)
        .snapshots();
  }
}

