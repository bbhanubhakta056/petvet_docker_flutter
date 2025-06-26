import 'package:flutter/material.dart';


class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    //TO DO: Implement actual login logic here
    // This is just a placeholder for the login page UI.
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Login Page',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to register page
              Navigator.pushNamed(context, '/register');
            },
            child: Text('Go to Register'),
          ),
        ],
      ),
    );
  }
}