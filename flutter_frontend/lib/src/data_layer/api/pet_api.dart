import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_frontend/src/models/pet.dart';

class PetApiService {
    static const String _baseUrl = 'http://localhost:3000/api/pets';

    Future<List<Pet>> fetchPets() async {
        final url = Uri.parse(_baseUrl); // Adjust the URL as needed
        // Mocked data for demonstration purposes
        final response = await http.get(url);
        if (response.statusCode != 200) {
        throw Exception('Failed to load pets');
        }
        // Parse the response body
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        List<Pet> pets = jsonResponse.map((pet) => Pet.fromJson(pet)).toList();
        return pets;
    }
}