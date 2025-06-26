import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetStart extends StatelessWidget {
  const GetStart({super.key});

  @override
  Widget build(BuildContext context) {
    // Function to fetch message from the server
    Future<String> fetchMessage() async {
      final response = await http.get(Uri.parse('http://localhost:3000/api/hello'));

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['message'];
      } else {
        throw Exception('Failed to load message');
      }
    } 
    return Scaffold(
        backgroundColor : Colors.red,
        appBar: AppBar(title: Text("KMS")),
        body: FutureBuilder<String>(
          future: fetchMessage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              // return Center(child: Text(snapshot.data ?? 'No message'));
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Header
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(Icons.pets, color: Colors.orange, size: 36),
                            const SizedBox(width: 10),
                            Text(
                              'PetCare Manager',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      // Hero Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            Image.asset('images/logo.png', height: 200),
                            const SizedBox(height: 10),
                            Text(
                              'Manage Your Pets with Ease',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Track health, appointments, and more — all in one place!',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                // Navigate to register/login
                                Navigator.pushNamed(context, '/register');
                              },
                              child: Text('Get Started'),
                            ),
                          ],
                        ),
                      ),
                    ]
                  )
                ),
              );
            }
          },
        ),
      );
  }
}