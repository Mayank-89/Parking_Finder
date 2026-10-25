
import 'package:flutter/material.dart';

import '../../services/booking_service.dart';
import '../payment/payment_screen.dart';

class BookingScreen extends StatefulWidget {
  final String parkingName;
  final double pricePerHour;
  final String? parkingId;

  const BookingScreen({
    super.key,
    required this.parkingName,
    required this.pricePerHour,
    this.parkingId,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int duration = 1;
  bool isBooking = false;

  Future<void> confirmBooking() async {
    if (isBooking) return;

    setState(() {
      isBooking = true;
    });

    try {
      final startTime = DateTime.now();
      final endTime = startTime.add(Duration(hours: duration));
      final totalPrice = duration * widget.pricePerHour;

      // Save the booking to Firestore.
      final bookingId = await BookingService().createBooking(
        parkingId: widget.parkingId ?? widget.parkingName,
        parkingName: widget.parkingName,
        startTime: startTime,
        endTime: endTime,
        amount: totalPrice,
        slotNumber: 'Not assigned',
      );

      if (!mounted) return;

      // Open payment only after the booking is saved.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PaymentScreen(
            parkingName: widget.parkingName,
            amount: totalPrice,
            bookingId: bookingId,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to create booking: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isBooking = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double totalPrice = duration * widget.pricePerHour;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Parking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.parkingName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Parking Duration',
              style: TextStyle(fontSize: 18),
            ),
            Slider(
              min: 1,
              max: 12,
              divisions: 11,
              value: duration.toDouble(),
              label: '$duration Hours',
              onChanged: (value) {
                setState(() {
                  duration = value.toInt();
                });
              },
            ),
            Text(
              '$duration Hour(s)',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            Text(
              'Total Price: ₹${totalPrice.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 22,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isBooking ? null : confirmBooking,
                child: isBooking
                    ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
                    : const Text('Confirm Booking'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
