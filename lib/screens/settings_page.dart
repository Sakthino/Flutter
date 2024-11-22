import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  await _auth.currentUser!
                      .delete(); // Delete current user account
                  // Add any navigation or feedback logic here
                } catch (e) {
                  print('Error deleting account: $e');
                  // Handle error as needed
                }
              },
              child: Text('Delete Account'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _auth.signOut(); // Sign out current user
                  // Add any navigation or feedback logic here
                } catch (e) {
                  print('Error signing out: $e');
                  // Handle error as needed
                }
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
