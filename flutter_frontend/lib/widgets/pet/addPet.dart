import 'package:flutter/material.dart';

class PetRegistrationScreen extends StatefulWidget {
  const PetRegistrationScreen({super.key});

  @override
  State<PetRegistrationScreen> createState() => _PetRegistrationScreenState();
}

class _PetRegistrationScreenState extends State<PetRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _petNameController = TextEditingController();
  final _breedController = TextEditingController();
  final _ageController = TextEditingController();
  final _colorPatternController = TextEditingController();
  final _weightController = TextEditingController();
  String _petType = 'Dog';
  String _gender = 'Male';
  bool _isVaccinated = false;
  bool _isNeutered = false;
  DateTime? _birthDate;

  @override
  void dispose() {
    _petNameController.dispose();
    _breedController.dispose();
    _ageController.dispose();
    _colorPatternController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _birthDate) {
      setState(() {
        _birthDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register New Pet'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: 600,
          width: 600,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade100, Colors.blue.shade300],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Pet Information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Pet Type Dropdown
                  DropdownButtonFormField<String>(
                    value: _petType,
                    decoration: const InputDecoration(
                      labelText: 'Pet Type',
                      prefixIcon: Icon(Icons.pets),
                    ),
                    items: ['Dog', 'Cat', 'Bird', 'Rabbit', 'Other']
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _petType = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // Pet Name
                  TextFormField(
                    controller: _petNameController,
                    decoration: const InputDecoration(
                      labelText: 'Pet Name',
                      prefixIcon: Icon(Icons.text_fields),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter pet name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Breed
                  TextFormField(
                    controller: _breedController,
                    decoration: const InputDecoration(
                      labelText: 'Breed',
                      prefixIcon: Icon(Icons.category),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter breed';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Gender Radio Buttons
                  const Text('Gender', style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Male'),
                          value: 'Male',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Female'),
                          value: 'Female',
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Age and Birth Date
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: _ageController,
                          decoration: const InputDecoration(
                            labelText: 'Age (years)',
                            prefixIcon: Icon(Icons.cake),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 3,
                        child: InkWell(
                          onTap: () => _selectDate(context),
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'Birth Date',
                              prefixIcon: Icon(Icons.calendar_today),
                            ),
                            child: Text(
                              _birthDate == null
                                  ? 'Select date'
                                  : '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Color/Pattern
                  TextFormField(
                    controller: _colorPatternController,
                    decoration: const InputDecoration(
                      labelText: 'Color/Pattern',
                      prefixIcon: Icon(Icons.palette),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Weight
                  TextFormField(
                    controller: _weightController,
                    decoration: const InputDecoration(
                      labelText: 'Weight (kg)',
                      prefixIcon: Icon(Icons.monitor_weight),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  // Health Status
                  const Text('Health Status', style: TextStyle(fontSize: 16)),
                  CheckboxListTile(
                    title: const Text('Vaccinated'),
                    value: _isVaccinated,
                    onChanged: (value) {
                      setState(() {
                        _isVaccinated = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Neutered/Spayed'),
                    value: _isNeutered,
                    onChanged: (value) {
                      setState(() {
                        _isNeutered = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  // Submit Button
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process form data
                        final newPet = {
                          'type': _petType,
                          'name': _petNameController.text,
                          'breed': _breedController.text,
                          'gender': _gender,
                          'age': _ageController.text,
                          'birthDate': _birthDate?.toString(),
                          'colorPattern': _colorPatternController.text,
                          'weight': _weightController.text,
                          'isVaccinated': _isVaccinated,
                          'isNeutered': _isNeutered,
                        };
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${_petNameController.text} registered successfully!'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                        
                        // Here you would typically save to database
                        print(newPet);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'REGISTER PET',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}