// import 'package:cubit_test/models/failure_model.dart';
// import 'package:cubit_test/models/joke_model.dart';
// import 'package:cubit_test/repositories/jokes/base_joke_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;

// class JokeRepository extends BaseJokeRepository {
//   JokeRepository();

//   @override
//   Future<dynamic> getJokes() async {
//     const String url = 'https://official-joke-api.appspot.com/jokes/ten';

//     var response = await http.get(Uri.parse(url));
//     debugPrint(response.statusCode.toString());
//     if (response.statusCode == 200) {
//       var json = convert.jsonDecode(response.body) as List;
//       debugPrint(json.toString());
//       return json.map((joke) => Joke.fromJson(joke)).toList();
//     } else {
//       var json = convert.jsonDecode(response.body);
//       return Failure.fromJson(json);
//     }
//   }

//   @override
//   Future<Joke> getOneJoke(int id) async {
//     String url = 'https://official-joke-api.appspot.com/jokes/$id';

//     var response = await http.get(Uri.parse(url));
//     var json = convert.jsonDecode(response.body);

//     return Joke.fromJson(json);
//   }
// }
