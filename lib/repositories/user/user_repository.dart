import 'package:cubit_test/models/models.dart';
import 'package:cubit_test/repositories/user/base_user_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class UserRepository extends BaseUserRepository {
  UserRepository();

  String baseUrl =
      'https://8ba6-2a02-2f08-ed12-3d00-716a-4b01-5df1-a815.ngrok-free.app';

  @override
  Future<dynamic> login(String email, String password) async {
    String url = '$baseUrl/api/auth/login';

    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: convert.jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      return User.fromJson(json);
    } else {
      var json = convert.jsonDecode(response.body);
      return Failure.fromJson(json);
    }
  }
}
