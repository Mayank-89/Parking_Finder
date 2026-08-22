import 'package:flutter/material.dart';

import '../payment/payment_screen.dart';

class BookingScreen extends StatefulWidget {
  final String parkingName;
  final double pricePerHour;

  const BookingScreen({
    super.key,
    required this.parkingName,
    required this.pricePerHour,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  int duration = 1;

  @override
  Widget build(BuildContext context) {
    double totalPrice = duration * widget.pricePerHour;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Parking"),
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
              "Parking Duration",
              style: TextStyle(fontSize: 18),
            ),

            Slider(
              min: 1,
              max: 12,
              divisions: 11,
              value: duration.toDouble(),
              label: "$duration Hours",
              onChanged: (value) {
                setState(() {
                  duration = value.toInt();
                });
              },
            ),

            Text(
              "$duration Hour(s)",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 30),

            Text(
              "Total Price : ₹${totalPrice.toStringAsFixed(0)}",
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PaymentScreen(
                      parkingName: widget.parkingName,
                      amount: totalPrice,
                    ),
                  ),
                );
              },
              child: const Text("Confirm Booking"),
            ),
          ),
          ],
        ),
      ),
    );
  }
}