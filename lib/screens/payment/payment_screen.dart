import 'package:flutter/material.dart';

import '../booking/booking_success_screen.dart';

class PaymentScreen extends StatelessWidget {
  final String parkingName;
  final double amount;

  const PaymentScreen({
    super.key,
    required this.parkingName,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              parkingName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Amount: ₹${amount.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 22,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Choose Payment Method",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                leading: const Icon(Icons.account_balance_wallet),
                title: const Text("UPI"),
                subtitle: const Text("Google Pay / PhonePe / Paytm"),
                onTap: () {},
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.credit_card),
                title: const Text("Credit / Debit Card"),
                onTap: () {},
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.account_balance),
                title: const Text("Net Banking"),
                onTap: () {},
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
                      builder: (_) => BookingSuccessScreen(
                        parkingName: parkingName,
                        amount: amount,
                      ),
                    ),
                  );
                },
                child: const Text("Pay Now"),
              ),
            )
          ],
        ),
      ),
    );
  }
}