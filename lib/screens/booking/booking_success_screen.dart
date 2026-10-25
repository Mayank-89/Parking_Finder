
import 'package:flutter/material.dart';

class BookingSuccessScreen extends StatelessWidget {
  final String parkingName;
  final double amount;
  final String bookingId;
  final String slotNumber;

  const BookingSuccessScreen({
    super.key,
    required this.parkingName,
    required this.amount,
    required this.bookingId,
    this.slotNumber = 'Not assigned',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Successful'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'Booking Confirmed',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.local_parking),
                      title: const Text('Parking'),
                      subtitle: Text(parkingName),
                    ),
                    ListTile(
                      leading: const Icon(Icons.confirmation_number),
                      title: const Text('Booking ID'),
                      subtitle: SelectableText(bookingId),
                    ),
                    ListTile(
                      leading: const Icon(Icons.garage),
                      title: const Text('Slot Number'),
                      subtitle: Text(slotNumber),
                    ),
                    ListTile(
                      leading: const Icon(Icons.currency_rupee),
                      title: const Text('Paid'),
                      subtitle: Text(
                        '₹${amount.toStringAsFixed(0)}',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(
                    context,
                        (route) => route.isFirst,
                  );
                },
                child: const Text('Back to Home'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
