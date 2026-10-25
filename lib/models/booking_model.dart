
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String bookingId;
  final String parkingName;
  final String slotNumber;
  final double amount;

  // Firestore booking details
  final String? userId;
  final String status;
  final String paymentStatus;
  final DateTime? startTime;
  final DateTime? endTime;
  final DateTime? createdAt;

  BookingModel({
    required this.bookingId,
    required this.parkingName,
    required this.slotNumber,
    required this.amount,
    this.userId,
    this.status = 'pending_payment',
    this.paymentStatus = 'pending',
    this.startTime,
    this.endTime,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'bookingId': bookingId,
      'parkingName': parkingName,
      'slotNumber': slotNumber,
      'amount': amount,
      'userId': userId,
      'status': status,
      'paymentStatus': paymentStatus,
      'startTime': startTime == null
          ? null
          : Timestamp.fromDate(startTime!),
      'endTime': endTime == null
          ? null
          : Timestamp.fromDate(endTime!),
      'createdAt': createdAt == null
          ? FieldValue.serverTimestamp()
          : Timestamp.fromDate(createdAt!),
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    DateTime? readDate(dynamic value) {
      if (value is Timestamp) return value.toDate();
      if (value is DateTime) return value;
      return null;
    }

    return BookingModel(
      bookingId: map['bookingId'] as String? ?? '',
      parkingName: map['parkingName'] as String? ?? '',
      slotNumber: map['slotNumber'] as String? ?? '',
      amount: (map['amount'] as num?)?.toDouble() ?? 0.0,
      userId: map['userId'] as String?,
      status: map['status'] as String? ?? 'pending_payment',
      paymentStatus: map['paymentStatus'] as String? ?? 'pending',
      startTime: readDate(map['startTime']),
      endTime: readDate(map['endTime']),
      createdAt: readDate(map['createdAt']),
    );
  }
}
