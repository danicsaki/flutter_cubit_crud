import 'package:cubit_test/models/models.dart';

abstract class BaseUserRepository {
  Future<dynamic> login(String email, String password) async {}

  Future<dynamic> signin(User user) async {}

  Future<dynamic> logout(String token) async {}
}
