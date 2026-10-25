// // // import 'package:flutter/material.dart';
// // //
// // // class SignupScreen extends StatelessWidget {
// // //   const SignupScreen({super.key});
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text("Sign Up"),
// // //       ),
// // //       body: const Center(
// // //         child: Text(
// // //           "Sign Up Screen",
// // //           style: TextStyle(fontSize: 24),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';
// //
// // class SignupScreen extends StatefulWidget {
// //   const SignupScreen({super.key});
// //
// //   @override
// //   State<SignupScreen> createState() => _SignupScreenState();
// // }
// //
// // class _SignupScreenState extends State<SignupScreen> {
// //   final nameController = TextEditingController();
// //   final emailController = TextEditingController();
// //   final phoneController = TextEditingController();
// //   final passwordController = TextEditingController();
// //   final confirmPasswordController = TextEditingController();
// //
// //   bool hidePassword = true;
// //   bool hideConfirmPassword = true;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Create Account"),
// //       ),
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           padding: const EdgeInsets.all(20),
// //           child: Column(
// //             children: [
// //
// //               const SizedBox(height: 20),
// //
// //               const Icon(
// //                 Icons.person_add,
// //                 size: 80,
// //                 color: Colors.green,
// //               ),
// //
// //               const SizedBox(height: 20),
// //
// //               const Text(
// //                 "Create Your Account",
// //                 style: TextStyle(
// //                   fontSize: 28,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //
// //               const SizedBox(height: 30),
// //
// //               TextField(
// //                 controller: nameController,
// //                 decoration: InputDecoration(
// //                   labelText: "Full Name",
// //                   prefixIcon: const Icon(Icons.person),
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                 ),
// //               ),
// //
// //               const SizedBox(height: 15),
// //
// //               TextField(
// //                 controller: emailController,
// //                 decoration: InputDecoration(
// //                   labelText: "Email",
// //                   prefixIcon: const Icon(Icons.email),
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                 ),
// //               ),
// //
// //               const SizedBox(height: 15),
// //
// //               TextField(
// //                 controller: phoneController,
// //                 keyboardType: TextInputType.phone,
// //                 decoration: InputDecoration(
// //                   labelText: "Phone Number",
// //                   prefixIcon: const Icon(Icons.phone),
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                 ),
// //               ),
// //
// //               const SizedBox(height: 15),
// //
// //               TextField(
// //                 controller: passwordController,
// //                 obscureText: hidePassword,
// //                 decoration: InputDecoration(
// //                   labelText: "Password",
// //                   prefixIcon: const Icon(Icons.lock),
// //                   suffixIcon: IconButton(
// //                     icon: Icon(
// //                       hidePassword
// //                           ? Icons.visibility_off
// //                           : Icons.visibility,
// //                     ),
// //                     onPressed: () {
// //                       setState(() {
// //                         hidePassword = !hidePassword;
// //                       });
// //                     },
// //                   ),
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                 ),
// //               ),
// //
// //               const SizedBox(height: 15),
// //
// //               TextField(
// //                 controller: confirmPasswordController,
// //                 obscureText: hideConfirmPassword,
// //                 decoration: InputDecoration(
// //                   labelText: "Confirm Password",
// //                   prefixIcon: const Icon(Icons.lock),
// //                   suffixIcon: IconButton(
// //                     icon: Icon(
// //                       hideConfirmPassword
// //                           ? Icons.visibility_off
// //                           : Icons.visibility,
// //                     ),
// //                     onPressed: () {
// //                       setState(() {
// //                         hideConfirmPassword =
// //                         !hideConfirmPassword;
// //                       });
// //                     },
// //                   ),
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                 ),
// //               ),
// //
// //               const SizedBox(height: 30),
// //
// //               SizedBox(
// //                 width: double.infinity,
// //                 height: 55,
// //                 child: ElevatedButton(
// //                   onPressed: () {},
// //                   child: const Text(
// //                     "Create Account",
// //                     style: TextStyle(fontSize: 18),
// //                   ),
// //                 ),
// //               ),
// //
// //               const SizedBox(height: 20),
// //
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //
// //                   const Text("Already have an account?"),
// //
// //                   TextButton(
// //                     onPressed: () {
// //                       Navigator.pop(context);
// //                     },
// //                     child: const Text("Login"),
// //                   ),
// //                 ],
// //               )
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import '../main/main_screen.dart';
//
// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});
//
//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }
//
// class _SignupScreenState extends State<SignupScreen> {
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//
//   bool isHidden = true;
//   bool isConfirmHidden = true;
//   bool isLoading = false;
//
//   Future<void> _signup() async {
//     final name = nameController.text.trim();
//     final email = emailController.text.trim();
//     final password = passwordController.text.trim();
//     final confirmPassword = confirmPasswordController.text.trim();
//
//     if (name.isEmpty ||
//         email.isEmpty ||
//         password.isEmpty ||
//         confirmPassword.isEmpty) {
//       _showMessage("Please fill all fields");
//       return;
//     }
//
//     if (password.length < 6) {
//       _showMessage("Password must be at least 6 characters");
//       return;
//     }
//
//     if (password != confirmPassword) {
//       _showMessage("Passwords do not match");
//       return;
//     }
//
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       if (!mounted) return;
//
//       _showMessage("Account created successfully");
//
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (_) => const MainScreen(),
//         ),
//             (route) => false,
//       );
//     } on FirebaseAuthException catch (e) {
//       String message = "Signup failed";
//
//       if (e.code == 'email-already-in-use') {
//         message = "An account already exists with this email";
//       } else if (e.code == 'invalid-email') {
//         message = "Please enter a valid email";
//       } else if (e.code == 'weak-password') {
//         message = "Password is too weak";
//       }
//
//       _showMessage(message);
//     } catch (e) {
//       _showMessage("Something went wrong");
//     }
//
//     if (mounted) {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   void _showMessage(String message) {
//     if (!mounted) return;
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Create Account"),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(25),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//
//               const Icon(
//                 Icons.local_parking,
//                 size: 70,
//                 color: Colors.green,
//               ),
//
//               const SizedBox(height: 20),
//
//               const Text(
//                 "Create Account",
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//
//               const SizedBox(height: 10),
//
//               const Text(
//                 "Create your Smart Parking Finder account",
//                 style: TextStyle(
//                   fontSize: 17,
//                   color: Colors.grey,
//                 ),
//               ),
//
//               const SizedBox(height: 35),
//
//               // Name
//               TextField(
//                 controller: nameController,
//                 textCapitalization: TextCapitalization.words,
//                 decoration: InputDecoration(
//                   labelText: "Name",
//                   prefixIcon: const Icon(Icons.person),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               // Email
//               TextField(
//                 controller: emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                   labelText: "Email",
//                   prefixIcon: const Icon(Icons.email),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               // Password
//               TextField(
//                 controller: passwordController,
//                 obscureText: isHidden,
//                 decoration: InputDecoration(
//                   labelText: "Password",
//                   prefixIcon: const Icon(Icons.lock),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       isHidden
//                           ? Icons.visibility_off
//                           : Icons.visibility,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         isHidden = !isHidden;
//                       });
//                     },
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               // Confirm Password
//               TextField(
//                 controller: confirmPasswordController,
//                 obscureText: isConfirmHidden,
//                 decoration: InputDecoration(
//                   labelText: "Confirm Password",
//                   prefixIcon: const Icon(Icons.lock_outline),
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       isConfirmHidden
//                           ? Icons.visibility_off
//                           : Icons.visibility,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         isConfirmHidden = !isConfirmHidden;
//                       });
//                     },
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 30),
//
//               // Signup Button
//               SizedBox(
//                 width: double.infinity,
//                 height: 55,
//                 child: ElevatedButton(
//                   onPressed: isLoading ? null : _signup,
//                   child: isLoading
//                       ? const SizedBox(
//                     height: 25,
//                     width: 25,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 2,
//                     ),
//                   )
//                       : const Text(
//                     "Create Account",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               Center(
//                 child: TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text("Already have an account? Login"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }\


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../main/main_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isHidden = true;
  bool isConfirmHidden = true;
  bool isLoading = false;

  // Future<void> _signup() async {
  //   final name = nameController.text.trim();
  //   final email = emailController.text.trim();
  //   final password = passwordController.text.trim();
  //   final confirmPassword = confirmPasswordController.text.trim();
  //
  //   // Validation
  //   if (name.isEmpty ||
  //       email.isEmpty ||
  //       password.isEmpty ||
  //       confirmPassword.isEmpty) {
  //     _showMessage("Please fill all fields");
  //     return;
  //   }
  //
  //   if (password.length < 6) {
  //     _showMessage("Password must be at least 6 characters");
  //     return;
  //   }
  //
  //   if (password != confirmPassword) {
  //     _showMessage("Passwords do not match");
  //     return;
  //   }
  //
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   try {
  //     // 1. Create Firebase Authentication account
  //     UserCredential userCredential =
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //
  //     // Get the newly created user
  //     User? user = userCredential.user;
  //
  //     if (user == null) {
  //       _showMessage("Unable to create account");
  //       return;
  //     }
  //
  //     // 2. Save user information in Firestore
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(user.uid)
  //         .set({
  //       'name': name,
  //       'email': email,
  //       'uid': user.uid,
  //       'createdAt': FieldValue.serverTimestamp(),
  //     });
  //
  //     // 3. Update Firebase Auth display name
  //     await user.updateDisplayName(name);
  //
  //     if (!mounted) return;
  //
  //     _showMessage("Account created successfully");
  //
  //     // 4. Go to MainScreen
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(
  //         builder: (_) => const MainScreen(),
  //       ),
  //           (route) => false,
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     String message = "Signup failed";
  //
  //     if (e.code == 'email-already-in-use') {
  //       message = "An account already exists with this email";
  //     } else if (e.code == 'invalid-email') {
  //       message = "Please enter a valid email";
  //     } else if (e.code == 'weak-password') {
  //       message = "Password is too weak";
  //     }
  //
  //     _showMessage(message);
  //   } catch (e) {
  //     _showMessage("Something went wrong");
  //   }
  //
  //   if (mounted) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  Future<void> _signup() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showMessage('Please fill all fields');
      return;
    }

    if (password.length < 6) {
      _showMessage('Password must be at least 6 characters');
      return;
    }

    if (password != confirmPassword) {
      _showMessage('Passwords do not match');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // 1. Create the Firebase Authentication account.
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        _showMessage('Account created, but user details are unavailable.');
        return;
      }

      // 2. Update the authentication profile.
      await user.updateDisplayName(name);

      // 3. Save the profile to Firestore.
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({
        'uid': user.uid,
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      _showMessage('Account created and profile saved successfully');

      // AuthGate can handle navigation using authStateChanges().
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'email-already-in-use':
          message = 'An account already exists with this email';
          break;
        case 'invalid-email':
          message = 'Please enter a valid email';
          break;
        case 'weak-password':
          message = 'Password is too weak';
          break;
        default:
          message = 'Authentication error: ${e.code}';
      }

      _showMessage(message);
    } on FirebaseException catch (e) {
      // Authentication may have succeeded even though the
      // Firestore profile write failed.
      _showMessage('Database error: ${e.code} — ${e.message ?? "Unknown error"}');
    } catch (e) {
      _showMessage('Unexpected error: $e');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }


  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              const Icon(
                Icons.local_parking,
                size: 70,
                color: Colors.green,
              ),

              const SizedBox(height: 20),

              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Create your Smart Parking Finder account",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 35),

              // Name
              TextField(
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: "Name",
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Email
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Password
              TextField(
                controller: passwordController,
                obscureText: isHidden,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Confirm Password
              TextField(
                controller: confirmPasswordController,
                obscureText: isConfirmHidden,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isConfirmHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        isConfirmHidden = !isConfirmHidden;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Signup Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _signup,
                  child: isLoading
                      ? const SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    "Create Account",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Already have an account? Login",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}