
import 'package:flutter/material.dart';

import '../../services/booking_service.dart';
import '../booking/booking_success_screen.dart';

class PaymentScreen extends StatefulWidget {
  final String parkingName;
  final double amount;
  final String bookingId;

  const PaymentScreen({
    super.key,
    required this.parkingName,
    required this.amount,
    required this.bookingId,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedMethod = 'UPI';
  bool isProcessing = false;

  Future<void> payNow() async {
    if (isProcessing) return;

    setState(() {
      isProcessing = true;
    });

    try {
      // DEMO ONLY: This simulates payment success.
      // Replace with verified payment-gateway confirmation
      // before using this flow in production.
      await BookingService().markPaymentSuccessful(widget.bookingId);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => BookingSuccessScreen(
            parkingName: widget.parkingName,
            amount: widget.amount,
            bookingId: widget.bookingId,
            slotNumber: 'Not assigned',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment could not be completed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
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
            const SizedBox(height: 10),
            Text(
              'Amount: ₹${widget.amount.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 22,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Choose Payment Method',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            Card(
              child: RadioListTile<String>(
                value: 'UPI',
                groupValue: selectedMethod,
                onChanged: isProcessing
                    ? null
                    : (value) {
                  if (value != null) {
                    setState(() => selectedMethod = value);
                  }
                },
                secondary: const Icon(Icons.account_balance_wallet),
                title: const Text('UPI'),
                subtitle: const Text('Google Pay / PhonePe / Paytm'),
              ),
            ),

            Card(
              child: RadioListTile<String>(
                value: 'Card',
                groupValue: selectedMethod,
                onChanged: isProcessing
                    ? null
                    : (value) {
                  if (value != null) {
                    setState(() => selectedMethod = value);
                  }
                },
                secondary: const Icon(Icons.credit_card),
                title: const Text('Credit / Debit Card'),
              ),
            ),

            Card(
              child: RadioListTile<String>(
                value: 'Net Banking',
                groupValue: selectedMethod,
                onChanged: isProcessing
                    ? null
                    : (value) {
                  if (value != null) {
                    setState(() => selectedMethod = value);
                  }
                },
                secondary: const Icon(Icons.account_balance),
                title: const Text('Net Banking'),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isProcessing ? null : payNow,
                child: isProcessing
                    ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
                    : Text(
                  'Pay ₹${widget.amount.toStringAsFixed(0)}',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
