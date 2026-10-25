
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnapshot) {
        if (authSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = authSnapshot.data;

        if (user == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Profile')),
            body: const Center(
              child: Text('Please log in to view your profile.'),
            ),
          );
        }

        return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          key: ValueKey(user.uid),
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .snapshots(),
          builder: (context, profileSnapshot) {
            if (profileSnapshot.hasError) {
              return Scaffold(
                appBar: AppBar(title: const Text('Profile')),
                body: const Center(
                  child: Text('Unable to load your profile.'),
                ),
              );
            }

            if (profileSnapshot.connectionState ==
                ConnectionState.waiting) {
              return Scaffold(
                appBar: AppBar(title: const Text('Profile')),
                body: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final data = profileSnapshot.data?.data();

            // Never show profile data belonging to another UID.
            final profileUid = data?['uid'];
            final validProfile = data != null &&
                (profileUid == null || profileUid == user.uid);

            final storedName = validProfile ? data['name'] : null;
            final name = storedName is String &&
                storedName.trim().isNotEmpty
                ? storedName
                : (user.displayName?.isNotEmpty == true
                ? user.displayName!
                : 'User');

            // Authentication is the source of truth for email.
            final email = user.email ?? 'No email available';

            return Scaffold(
              appBar: AppBar(
                title: const Text('Profile'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    const CircleAvatar(
                      radius: 65,
                      backgroundColor: Color(0xFFB9F0B3),
                      child: Icon(
                        Icons.person,
                        size: 75,
                        color: Color(0xFF24532D),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      email,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 35),

                    ListTile(
                      leading: const Icon(Icons.bookmark),
                      title: const Text('My Bookings'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        // Connect your existing booking history screen.
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.favorite),
                      title: const Text('Favourite Parking'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        // Connect your favourites screen.
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Logout'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () async {
                        final shouldLogout = await showDialog<bool>(
                          context: context,
                          builder: (dialogContext) => AlertDialog(
                            title: const Text('Logout'),
                            content: const Text(
                              'Are you sure you want to log out?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(dialogContext, false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(dialogContext, true),
                                child: const Text('Logout'),
                              ),
                            ],
                          ),
                        );

                        if (shouldLogout != true) return;

                        try {
                          await FirebaseAuth.instance.signOut();
                          // AuthGate automatically displays LoginScreen.
                        } catch (e) {
                          if (!context.mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Logout failed: $e'),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
