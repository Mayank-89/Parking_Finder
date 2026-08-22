import 'package:flutter/material.dart';

import '../../database/booking_data.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking History"),
      ),
      body: bookingHistory.isEmpty
          ? const Center(
        child: Text("No Bookings Yet"),
      )
          : ListView.builder(
        itemCount: bookingHistory.length,
        itemBuilder: (context, index) {
          final booking = bookingHistory[index];

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
                  Text("Booking ID: ${booking.bookingId}"),
                  Text("Slot: ${booking.slotNumber}"),
                  Text("₹${booking.amount.toStringAsFixed(0)}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}