// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_frontend/src/data_layer/api/pet_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_frontend/src/models/pet.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv for environment variables

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;
  String _selectedPet = 'All Pets';

  late Future<List<Pet>> futurePets;
  final PetApiService _apiService = PetApiService();

  @override
  void initState() {
    super.initState();
    // Initialize any data or state here if needed
    futurePets = _apiService.fetchPets();
  }

  // void  fetchPets() async {
  //   try{
  //     // futurePets = _apiService.fetchPets();
  //     final pets = _apiService.fetchPets();
  //     setState(() {
  //       futurePets =  pets;
  //     });
  //   } catch (e) {
  //     print('Error fetching pets: $e');
  //     // Handle error appropriately, e.g., show a snackbar or dialog
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to load pets: $e')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Management Dashboard'),
        actions: [
          _buildPetDropdown(),
          const SizedBox(width: 16),
        ],
      ),
      drawer: _buildNavigationDrawer(),
      body: _getBodyContent(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'My Pets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Appointments',
          ),
        ],
      ),
    );
  }

  Widget _buildPetDropdown() {
    return DropdownButton<String>(
      value: _selectedPet,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      underline: Container(
        height: 2,
        color: Colors.white,
      ),
      onChanged: (String? newValue) {
        setState(() {
          _selectedPet = newValue!;
        });
      },
      items: <String>['All Pets', 'Max', 'Bella', 'Charlie', 'Luna']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildNavigationDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Pet Management',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              setState(() {
                _currentIndex = 0;
              });
              Navigator.pop(context);
            },
          ),
          ExpansionTile(
            leading: const Icon(Icons.pets),
            title: const Text('Pets'),
            children: [
              ListTile(
                title: const Text('All Pets'),
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                    _selectedPet = 'All Pets';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Add New Pet'),
                onTap: () {
                  // Navigate to add pet screen
                  Navigator.pushNamed(context, '/addPet');
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.medical_services),
            title: const Text('Health'),
            children: [
              ListTile(
                title: const Text('Vaccinations'),
                onTap: () {
                  // Navigate to vaccinations screen
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Medications'),
                onTap: () {
                  // Navigate to medications screen
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Medical History'),
                onTap: () {
                  // Navigate to medical history screen
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Appointments'),
            onTap: () {
              setState(() {
                _currentIndex = 2;
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Navigate to settings screen
              Navigator.pop(context);
            },
          ),
            ListTile(
            leading: const Icon(Icons.logout_sharp),
            title: const Text('Log Out'),
            onTap: () {
              // Navigate to settings screen
              Navigator.pushNamed( context, '/');
            },
          ),
        ],
      ),
    );
  }

  Widget _getBodyContent() {
    switch (_currentIndex) {
      case 0:
        return _buildDashboardContent();
      case 1:
        return _buildPetsContent();
      case 2:
        return _buildAppointmentsContent();
      default:
        return _buildDashboardContent();
    }
  }

  Widget _buildDashboardContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Overview',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildStatsRow(),
          const SizedBox(height: 24),
          const Text(
            'Upcoming Appointments',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _buildAppointmentsList(),
          const SizedBox(height: 24),
          const Text(
            'Recent Activities',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _buildActivitiesList(),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(child: _buildStatCard('Pets', '3', Icons.pets, Colors.blue)),
        Expanded(child: _buildStatCard('Appointments', '2', Icons.calendar_today, Colors.green)),
        Expanded(
          child: _buildStatCard(
              'Medications', '1', Icons.medical_services, Colors.orange),
        ),
        Expanded(child: _buildStatCard('Vaccinations', '1', Icons.local_hospital, Colors.red)),
      ],
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, size: 30, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentsList() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.calendar_today, color: Colors.blue),
              title: const Text('Annual Checkup - Max'),
              subtitle: const Text('Tomorrow, 10:00 AM at PetCare Clinic'),
              trailing: IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.calendar_today, color: Colors.green),
              title: const Text('Vaccination - Bella'),
              subtitle: const Text('June 25, 2:30 PM at Animal Hospital'),
              trailing: IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivitiesList() {
    // ignore: prefer_const_constructors
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.medical_services, color: Colors.orange),
              title: Text('Medication given to Charlie'),
              subtitle: Text('Today, 8:00 AM - Flea treatment'),
              trailing: Text('1h ago'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.local_dining, color: Colors.purple),
              title: Text('Fed Luna'),
              subtitle: Text('Today, 7:30 AM - Dry food 1 cup'),
              trailing: Text('2h ago'),
            ),
            Divider(),
            ListTile(
              // leading: const Icon(Icons.walk, color: Colors.teal),
              title: Text('Walked Max'),
              subtitle: Text('Yesterday, 6:00 PM - 30 minutes'),
              trailing: Text('1d ago'),
            ),
          ],
        ),
      ),
    );
  }

  // Future<List<Pet>> fetchPets() async {
  //   final String baseUrl = dotenv.env['BASE_URI'] ?? '';
  //   final registerUrl = Uri.parse('${baseUrl}/api/pets'); // Adjust the URL as needed
  //   // Mocked data for demonstration purposes
  //   final response = await http.get(registerUrl);
  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to load pets');
  //   }
  //   // Parse the response body
  //   final List<dynamic> jsonResponse = jsonDecode(response.body);
  //   List<Pet> pets = jsonResponse.map((pet) => Pet.fromJson(pet)).toList();
  //   return pets;
  // }

  

  // This function fetches the list of pets from the backend
  // It returns a Future that resolves to a list of Pet objects
  Widget _buildPetsContent() {
    return FutureBuilder<List<Pet>>(

      future: futurePets, // Use the futurePets variable to fetch pets
      // future: _apiService.fetchPets(), // Fetch pets from the API
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${snapshot.error}'),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        futurePets = _apiService.fetchPets();
                      });
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No pets found.'));
        } else {
          final pets = snapshot.data!;
          return ListView.builder(
            itemCount: pets.length,
            itemBuilder: (context, index) {
              final pet = pets[index];
              return Container(
                height: 80 ,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.redAccent,
                ),
                child: ListTile(
                  leading: 
                  // pet.imageUrl.isNotEmpty
                  //       ? CircleAvatar(
                  //           backgroundImage: NetworkImage(pet.imageUrl),
                  //         ) :
                        const CircleAvatar(
                            child: Icon(Icons.pets),
                          ),
                  title: Text(pet.name),
                  subtitle: Text('${pet.species} - ${pet.breed}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      // Handle more options
                      Navigator.pushNamed(
                        context,
                        '/petDetails',
                        arguments: pet, // Pass the pet object to the details page
                      );  
                    },
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildAppointmentsContent() {
    return Center(
      child: Text('Appointments Content for $_selectedPet'),
    );
  }
}