// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';

class PetPortfolioPage extends StatefulWidget {
  @override
  State<PetPortfolioPage> createState() => _PetPortfolioPageState();
}

class _PetPortfolioPageState extends State<PetPortfolioPage> {
  final String petName = 'Max';

  final String breed = 'Golden Retriever';

  final int age = 3;

  final String gender = 'Male';

  final String description = 'Max is a friendly and energetic golden retriever who loves playing fetch and going for long walks. He gets along well with children and other dogs.';

  final double healthScore = 0.50; 
 // 85%
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with pet image
            _buildHeader(context),
            
            // Pet details section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pet name and basic info
                 // _buildPetBasicInfo(),
                  
                 // SizedBox(height: 20),
                  
                  // Description section
                  _buildDescriptionSection(),
                  
                  SizedBox(height: 25),
                  
                  // Health status
                  _buildHealthSection(),
                  
                  SizedBox(height: 25),
                  
                  // Appointments
                  _buildAppointmentsSection(),
                  //Vaccination Section
                  SizedBox(height: 25), 
                  _buildVaccinationSection(),
                // Vaccination Section
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 145, 81, 214), Color(0xFF2575FC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 20,
          child: Hero(
            tag: 'pet-image',
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                image: DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1586671267731-da2cf3ceeb80?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 160,
          child: _buildPetBasicInfo(),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: IconButton(
            iconSize:30,
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }

  Widget _buildPetBasicInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          petName,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.indigo[900],
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            _buildInfoChip(Icons.pets, breed),
            SizedBox(width: 10),
            _buildInfoChip(Icons.cake, '$age years'),
            SizedBox(width: 10),
            _buildInfoChip(
              gender == 'Male' ? Icons.male : Icons.female, 
              gender
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Chip(
      backgroundColor: Colors.indigo[50],
      avatar: Icon(icon, size: 18, color: Colors.indigo),
      label: Text(
        text,
        style: TextStyle(color: Colors.indigo[800]),
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.indigo[900],
          ),
        ),
        SizedBox(height: 10),
        Text(
          description,
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildHealthSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Health Status',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.indigo[900],
          ),
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              LinearProgressIndicator(
                value: healthScore,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getHealthColor(healthScore),
                ),
                minHeight: 12,
                borderRadius: BorderRadius.circular(6),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Overall Health',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    '${(healthScore * 100).toInt()}%',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _getHealthColor(healthScore),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildVaccinationSection() {
     return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildHealthIndicator('Vaccinations', Icons.medical_services, Colors.green),
                  _buildHealthIndicator('Last Checkup', Icons.calendar_today, Colors.blue),
                  _buildHealthIndicator('Weight', Icons.monitor_weight, Colors.orange),
                ],
              );
  } 

  Widget _buildHealthIndicator(String label, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildAppointmentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Upcoming Appointments',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo[900],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text('View All'),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildAppointmentItem(
                'Annual Checkup',
                'Dr. Smith',
                'May 15, 2023 - 10:00 AM',
                Colors.blue,
              ),
              Divider(height: 30, thickness: 1),
              _buildAppointmentItem(
                'Vaccination',
                'Dr. Johnson',
                'June 2, 2023 - 2:30 PM',
                Colors.green,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAppointmentItem(String title, String doctor, String date, Color color) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 4),
              Text(
                doctor,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              date.split(' - ')[0],
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              date.split(' - ')[1],
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color _getHealthColor(double score) {
    if (score > 0.7) return Colors.green;
    if (score > 0.4) return Colors.orange;
    return Colors.red;
  }
}