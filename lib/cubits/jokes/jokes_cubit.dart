// import 'package:bloc/bloc.dart';
// import 'package:cubit_test/models/failure_model.dart';
// import 'package:cubit_test/models/joke_model.dart';
// import 'package:cubit_test/repositories/jokes/joke_repository.dart';
// import 'package:equatable/equatable.dart';
// // import 'package:meta/meta.dart';

// part 'jokes_state.dart';

// class JokesCubit extends Cubit<JokesState> {
//   final JokeRepository repository;
//   JokesCubit({required this.repository}) : super(const JokesState());

//   Future<void> fetchJokes() async {
//     emit(state.copyWith(status: JokesStateStatus.loading));

//     final response = await repository.getJokes();
//     if (response is List<Joke>) {
//       emit(
//         state.copyWith(
//           status: JokesStateStatus.success,
//           jokes: response,
//         ),
//       );
//     } else {
//       emit(state.copyWith(
//         status: JokesStateStatus.failure,
//         exception: response,
//       ));
//     }
//   }

//   // Future<void> getOneJoke(int id) async {
//   //   emit(JokesLoading());

//   //   try {
//   //     final response = await _repository.getOneJoke(id);
//   //     emit(JokeLoaded(response));
//   //   } on Exception {
//   //     emit(JokesFailure());
//   //   }
//   // }
// }
