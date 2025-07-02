import 'package:flutter/material.dart';
// import 'dart:convert';
import 'package:flutter_frontend/widgets/home/getStart.dart';
import 'package:flutter_frontend/widgets/auth/login.dart';
import 'package:flutter_frontend/widgets/auth/register.dart';
import 'package:flutter_frontend/widgets/home/dashboard.dart';
import 'package:flutter_frontend/widgets/home/petDetails.dart';
import 'package:flutter_frontend/widgets/pet/addPet.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_frontend/src/data_layer/api/user_api.dart'; // Import the API service

void main() async {
  print('App started');
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); 
  
  runApp(const MyApp());// Load environment variables from .env file
}

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
        '/': (context) => const GetStart(), // - '/': The initial screen (GetStart widget)
        '/login': (context) => const LoginScreen(), // - '/login': The login screen (Login widget)

        '/petDetails': (context) {
          // - '/petDetails': The pet details screen (PetPortfolioPage widget)
          // This route can be used to display details of a specific pet.
          // It can accept arguments to pass the pet data to the PetPortfolioPage.
          final pet = ModalRoute.of(context)?.settings.arguments;
          return PetPortfolioPage();
        },

        // - The routes can be accessed using Navigator.pushNamed(context, '/register');
        '/register': (context) => const Register(), // - '/register': The registration screen (Register widget)
        '/dashboard': (context) => const DashboardPage(), // - '/dashboard': The dashboard screen (DashboardPage widget)  
        '/addPet': (context) => const PetRegistrationScreen(), // - '/addPet': The pet registration screen (PetRegistrationScreen widget)   
        // - Additional routes can be added as needed for other features like home, settings, profile, etc.
        // uncomment the following lines to add more routes

        // '/settings': (context) => Settings(), // - '/settings': The settings screen (Settings widget)
        // '/profile': (context) => Profile(), // - '/profile': The user profile screen (Profile widget)
      },
    );
  }
}
