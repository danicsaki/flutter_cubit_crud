import 'package:bloc/bloc.dart';
import 'package:cubit_test/models/models.dart';
import 'package:cubit_test/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository repository;
  UserCubit({required this.repository}) : super(const UserState());

  Future<dynamic> login(String email, String password) async {
    emit(state.copyWith(status: UserStateStatus.loading));

    final response = await repository.login(email, password);

    if (response is User) {
      emit(
        state.copyWith(
          status: UserStateStatus.success,
          user: response,
        ),
      );
      return response;
    } else {
      emit(
        state.copyWith(
          status: UserStateStatus.failure,
          exception: response,
        ),
      );
      return response;
    }
  }
}
