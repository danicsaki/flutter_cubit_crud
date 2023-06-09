import 'package:equatable/equatable.dart';

class Pet extends Equatable {
  final String? id;
  final String name;
  final int age;
  final String image;
  final String type;
  final String characteristics;
  final String description;
  final List coordinates;
  final String status;
  final String race;

  const Pet({
    this.id,
    required this.name,
    required this.age,
    required this.image,
    required this.type,
    required this.characteristics,
    required this.description,
    required this.coordinates,
    required this.status,
    required this.race,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        age,
        image,
        type,
        characteristics,
        description,
        coordinates,
        status,
        race,
      ];

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['_id'],
      name: json['name'],
      age: json['age'],
      image: json['image'],
      type: json['type'],
      characteristics: json['characteristics'],
      description: json['description'],
      coordinates: json['coordinates'],
      status: json['status'],
      race: json['race'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'age': age,
        'image': image,
        'type': type,
        'characteristics': characteristics,
        'description': description,
        'coordinates': coordinates,
        'status': status,
        'race': race,
      };
}
