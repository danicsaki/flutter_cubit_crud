part of 'user_cubit.dart';

enum UserStateStatus { initial, loading, success, failure }

class UserState extends Equatable {
  final UserStateStatus status;
  final User? user;
  final Failure? exception;

  const UserState(
      {this.status = UserStateStatus.initial, this.user, this.exception});

  UserState copyWith({
    UserStateStatus? status,
    User? user,
    Failure? exception,
  }) {
    return UserState(
      status: status ?? this.status,
      user: user ?? this.user,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [status, user, exception];
}
