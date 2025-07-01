import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_frontend/src/models/pet.dart';

class UserApiService {
    static const String _baseUrl = 'http://192.168.1.77:3000/';
    // static const String _baseUrl = 'http://localhost:3000/api/pets'; // Adjust the URL as needed
    Future<String> fetchMessage() async {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['message'];
      } else {
        throw Exception('Failed to load message');
      }
    } 
}