class Pet {
    final String name;
    final int age;
    final String species;
    final String breed;
    final String color;
    final String gender;
    final String owner;
    final String imageUrl;
    final String healthStatus;

    Pet({
        required this.name,
        required this.age,
        required this.species,
        required this.breed,
        required this.color,
        required this.gender,
        required this.owner,
        required this.imageUrl,
        required this.healthStatus,
    });

    // Factory constructor to create a Pet instance from JSON
    factory Pet.fromJson(Map<String, dynamic> json) {
        return Pet(
            name: json['name'] ?? '', // Default to empty string if name is null
            age: json['age'] ?? 0, // Default to 0 if age is null
            // Ensure species, breed
            species: json['species'] ?? '', // Default to empty string if species is null
            // Ensure breed, color
            breed: json['breed'] ?? '', // Default to empty string if breed is null
            color: json['color'] ?? '', // Default to empty string if color is null
            gender: json['gender'] ?? '', // Default
            owner: json['owner'] ?? '', // Default to empty string if owner is null
            imageUrl: json['imageUrl'] ?? '', // Default to empty string if imageUrl is null
            healthStatus: json['healthStatus'] ?? '', // Default to
        );
    }
    
    // Method to convert a Pet instance to JSON
    Map<String, dynamic> toJson() {
        return {
            'name': name,
            'age': age,
            'species': species,
            'breed': breed,
            'color': color,
            'gender': gender,
            'owner': owner,
            'imageUrl': imageUrl,
            'healthStatus': healthStatus, // Convert HealthStatus to JSON
        };
    }
    
    // @override
    // String toString() {
    //     return 'Pet{name: $name, age: $age, species: $species, breed: $breed, color: $color, gender: $gender, owner: $owner}';
    // }

    // // Method to display pet details
    // String displayDetails() {
    //     return 'Name: $name\nAge: $age\nSpecies: $species\nBreed: $breed\nColor: $color\nGender: $gender\nOwner: $owner';
    // }

    // // Method to check if the pet is a dog
    // bool isDog() {
    //     return species.toLowerCase() == 'dog';
    // }


}