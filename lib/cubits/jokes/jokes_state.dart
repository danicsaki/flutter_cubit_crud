// part of 'jokes_cubit.dart';

// enum JokesStateStatus { initial, loading, success, failure }

// class JokesState extends Equatable {
//   final JokesStateStatus status;
//   final List<Joke> jokes;
//   final Failure? exception;

//   const JokesState(
//       {this.status = JokesStateStatus.initial,
//       this.jokes = const [],
//       this.exception});

//   JokesState copyWith({
//     JokesStateStatus? status,
//     List<Joke>? jokes,
//     Failure? exception,
//   }) {
//     return JokesState(
//       status: status ?? this.status,
//       jokes: jokes ?? this.jokes,
//       exception: exception ?? this.exception,
//     );
//   }

//   @override
//   List<Object?> get props => [status, jokes, exception];
// }
