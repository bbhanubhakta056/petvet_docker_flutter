import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    // TO DO: Implement actual registration logic here
    // This is just a placeholder for the registration page UI.
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Register Page',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to login page
              Navigator.pushNamed(context, '/login');
            },
            child: Text('Go to Login'),
          ),
        ],
      ),
    );
  }
}