
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/booking_model.dart';
import '../../services/booking_service.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Booking History'),
        ),
        body: const Center(
          child: Text('Please log in to view your bookings.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: BookingService().watchMyBookings(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Unable to load bookings. Please try again.'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final documents = snapshot.data?.docs ?? [];

          final bookings = documents.map((doc) {
            return BookingModel.fromMap({
              ...doc.data(),
              'bookingId': doc.data()['bookingId'] ?? doc.id,
            });
          }).toList();

          // Show the most recent bookings first.
          bookings.sort((a, b) {
            return (b.createdAt ?? DateTime(2000))
                .compareTo(a.createdAt ?? DateTime(2000));
          });

          if (bookings.isEmpty) {
            return const Center(
              child: Text('No Bookings Yet'),
            );
          }

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(
                    Icons.local_parking,
                    color: Colors.green,
                  ),
                  title: Text(booking.parkingName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Booking ID: ${booking.bookingId}'),
                      Text('Slot: ${booking.slotNumber}'),
                      Text('Amount: ₹${booking.amount.toStringAsFixed(0)}'),
                      Text('Status: ${booking.status.replaceAll('_', ' ')}'),
                      Text('Payment: ${booking.paymentStatus}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
