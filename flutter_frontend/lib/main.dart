import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Future<String> fetchMessage() async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/hello'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    } else {
      throw Exception('Failed to load message');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme : ThemeData(
        // 🌈 Primary App Colors
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          secondary: Colors.deepOrangeAccent,
        ),
      ),
      home: Scaffold(
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
              // return Column(
              //   children: [
              //     // Header
              //     Container(
              //       padding:  EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              //       color: Colors.white,
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text(
              //             'YourLogo',
              //             style: TextStyle(
              //               fontSize: 24,
              //               fontWeight: FontWeight.bold,
              //               color: Colors.blue,
              //             ),
              //           ),
              //           Row(
              //             children: [
              //               TextButton(
              //                 onPressed: () {},
              //                 child:  Text('Login'),
              //               ),
              //               SizedBox(width: 12),
              //               ElevatedButton(
              //                 onPressed: () {},
              //                 style: ElevatedButton.styleFrom(
              //                   backgroundColor: Colors.blue,
              //                 ),
              //                 child:  Text('Register'),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),

              //     // Body
              //     Expanded(
              //       child: Center(
              //         child: Padding(
              //           padding: EdgeInsets.symmetric(horizontal: 24),
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text(
              //                 'Welcome to Our Platform',
              //                 style: TextStyle(
              //                   fontSize: 32,
              //                   fontWeight: FontWeight.bold,
              //                   color: Colors.black87,
              //                 ),
              //                 textAlign: TextAlign.center,
              //               ),
              //               SizedBox(height: 20),
              //               Text(
              //                 'We provide an easy way to access our services.\nLogin if you already have an account or register to get started.',
              //                 style: TextStyle(
              //                   fontSize: 16,
              //                   color: Colors.black54,
              //                 ),
              //                 textAlign: TextAlign.center,
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // );
            }
          },
        ),
      ),
    );
  }
}
