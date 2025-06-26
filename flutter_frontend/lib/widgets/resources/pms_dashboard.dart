import 'package:flutter/material.dart';

void main() {
  runApp(const PetManagementApp());
}

class PetManagementApp extends StatelessWidget {
  const PetManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Management System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  String _selectedPet = 'All Pets';

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
                  Navigator.pop(context);
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
        _buildStatCard('Pets', '3', Icons.pets, Colors.blue),
        _buildStatCard('Appointments', '2', Icons.calendar_today, Colors.green),
        _buildStatCard(
            'Medications', '1', Icons.medical_services, Colors.orange),
        _buildStatCard('Vaccinations', '1', Icons.local_hospital, Colors.red),
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
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.medical_services, color: Colors.orange),
              title: const Text('Medication given to Charlie'),
              subtitle: const Text('Today, 8:00 AM - Flea treatment'),
              trailing: const Text('1h ago'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.local_dining, color: Colors.purple),
              title: const Text('Fed Luna'),
              subtitle: const Text('Today, 7:30 AM - Dry food 1 cup'),
              trailing: const Text('2h ago'),
            ),
            const Divider(),
            ListTile(
              // leading: const Icon(Icons.walk, color: Colors.teal),
              title: const Text('Walked Max'),
              subtitle: const Text('Yesterday, 6:00 PM - 30 minutes'),
              trailing: const Text('1d ago'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetsContent() {
    return Center(
      child: Text('Pets Content for $_selectedPet'),
    );
  }

  Widget _buildAppointmentsContent() {
    return Center(
      child: Text('Appointments Content for $_selectedPet'),
    );
  }
}
