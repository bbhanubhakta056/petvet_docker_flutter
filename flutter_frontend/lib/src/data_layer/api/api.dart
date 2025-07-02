import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_frontend/src/models/pet.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:js' as js;

void logToBrowserConsole(String message) {
  js.context.callMethod('console.log', [message]);
}

class UserApiService {
    final String _baseUrl = dotenv.env['BASE_URI'] ?? 'sdfdsf'; // Use dotenv to get the base URL from .env file
    void logUrl() {
      print('API URL: $_baseUrl');
    } // Debugging line to check the base URL
    // static const String _baseUrl = 'http://localhost:3000'; // Adjust the URL as needed
    Future<String> fetchMessage() async {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['message'];
      } else {
        throw Exception('Failed to load message');
      }
    } 
}