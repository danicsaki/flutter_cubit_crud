import 'package:cubit_test/models/pet_model.dart';

abstract class BasePetsRepository {
  Future<dynamic> getPets() async {}

  Future<dynamic> addPet(Pet pet) async {}

  Future<dynamic> updatePet(String id, Pet pet) async {}

  Future<dynamic> deletePet(String id) async {}
}
