import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_frontend/src/models/pet.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv for environment variables

class PetApiService {
    final String _baseUrl = dotenv.env['BASE_URI'] ?? ''; // Use dotenv to get the base URL from .env file
    late final String _petsEndpoint; // Adjust the endpoint as needed

    PetApiService() {
        _petsEndpoint = '$_baseUrl/api/pets';   
    }

    // This function fetches a list of pets from the backend
    Future<List<Pet>> fetchPets() async {
        final url = Uri.parse(_petsEndpoint); // Adjust the URL as needed
        // Mocked data for demonstration purposes
        final response = await http.get(url);
        print('Fetching pets from: $_petsEndpoint'); // Debugging line to check the URL
        print('Response status: ${response.statusCode}'); // Debugging line to check the
        if (response.statusCode != 200) {
            throw Exception('Failed to load pets');
        }
        // Parse the response body
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        List<Pet> pets = jsonResponse.map((pet) => Pet.fromJson(pet)).toList();
        return pets;
    }

    // This function handles user registration by sending a POST request to the backend
    Future<void> addPet(Pet pet) async {
        final url = Uri.parse(_petsEndpoint); // Adjust the URL as needed
        print('URL: $url'); // Debugging line to check the URL
        final response = await http.post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(pet.toJson()), // Convert Pet instance to JSON
        );
        print('Response status: ${response.statusCode}'); // Debugging line to check the response status
        if (response.statusCode != 201 && response.statusCode != 200) {
            throw Exception('Failed to add pet');
        }
    }
    
}