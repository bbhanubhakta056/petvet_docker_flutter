import 'package:flutter/material.dart';
// import 'dart:convert';
import 'package:flutter_frontend/widgets/home/getStart.dart';
import 'package:flutter_frontend/widgets/auth/login.dart';
import 'package:flutter_frontend/widgets/auth/register.dart';
import 'package:flutter_frontend/widgets/home/dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
// Main entry point of the application
  // This widget is the root of your application.
  // It sets up the MaterialApp and defines the routes.
  // It also sets the theme and initial route for the app.
  // The app starts with the GetStart widget, which is the initial screen.
  // The app uses a Material Design theme with a primary color of blue.
  // The app has routes defined for login and register pages.
  // The GetStart widget is the first screen that users see when they open the app.
  
  @override
  Widget build(BuildContext context) {
    // bool isDesktop = MediaQuery.of(context).size.width > 600;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme : ThemeData(
        // 🌈 Primary App Colors
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          secondary: Colors.deepOrangeAccent,
        ),
      ), 
      
      // Define the routes for the app
      // 🌐 Initial Route
      // This is the first screen that will be displayed when the app starts.
      initialRoute: '/', 
      // 📍 Routes Map
      // This map defines the available routes in the app.

      routes: {
        '/': (context) => GetStart(), // - '/': The initial screen (GetStart widget)
        '/login': (context) => Login(), // - '/login': The login screen (Login widget)

        // - The routes can be accessed using Navigator.pushNamed(context, '/register');
        '/register': (context) => Register(), // - '/register': The registration screen (Register widget)
        '/dashboard': (context) => DashboardPage(), // - '/dashboard': The dashboard screen (DashboardPage widget)  
        // - Additional routes can be added as needed for other features like home, settings, profile, etc.
        // uncomment the following lines to add more routes

        // '/settings': (context) => Settings(), // - '/settings': The settings screen (Settings widget)
        // '/profile': (context) => Profile(), // - '/profile': The user profile screen (Profile widget)
      },
    );
  }
}
