import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              const CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),

              const SizedBox(height: 20),

              const Text(
                "Mayank Awasthi",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "mayank@email.com",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),

              ListTile(
                leading: const Icon(Icons.bookmark),
                title: const Text("My Bookings"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),

              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text("Favourite Parking"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),

              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}