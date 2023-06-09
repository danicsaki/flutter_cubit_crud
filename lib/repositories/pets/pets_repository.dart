import 'package:cubit_test/models/failure_model.dart';
import 'package:cubit_test/models/pet_model.dart';
import 'package:cubit_test/repositories/pets/base_pets_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PetsRepository extends BasePetsRepository {
  PetsRepository();

  String baseUrl =
      'https://8ba6-2a02-2f08-ed12-3d00-716a-4b01-5df1-a815.ngrok-free.app';

  @override
  Future<dynamic> getPets() async {
    String url = '$baseUrl/api/pets/all';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body) as List;
      return json.map((pet) => Pet.fromJson(pet)).toList();
    } else {
      var json = convert.jsonDecode(response.body);
      return Failure.fromJson(json);
    }
  }

  @override
  Future<dynamic> addPet(Pet pet) async {
    String url = '$baseUrl/api/pets/add';

    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: convert.jsonEncode(pet),
    );

    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      return Failure(type: 'success', message: json['message']);
    } else {
      var json = convert.jsonDecode(response.body);
      return Failure.fromJson(json);
    }
  }

  @override
  Future<dynamic> updatePet(String id, Pet pet) async {
    String url = '$baseUrl/api/pets/$id';

    var response = await http.put(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: convert.jsonEncode(pet),
    );

    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      return Failure(type: 'success', message: json['message']);
    } else {
      var json = convert.jsonDecode(response.body);
      return Failure.fromJson(json);
    }
  }

  @override
  Future<dynamic> deletePet(String id) async {
    String url = '$baseUrl/api/pets/$id';

    var response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      return Failure(type: 'success', message: json['message']);
    } else {
      var json = convert.jsonDecode(response.body);
      return Failure.fromJson(json);
    }
  }
}
