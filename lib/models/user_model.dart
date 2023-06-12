import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String firstName;
  final String lastName;
  final String email;
  final List roles;

  const User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.roles,
  });

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        roles,
      ];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      roles: json['roles'],
    );
  }

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'roles': roles,
      };
}
