import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_v2_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String username, String password) async {
    emit(LoginLoading());

    // Simulating an asynchronous login request
    await Future.delayed(const Duration(seconds: 2));

    // Mocking the response status code
    const statusCode =
        200; // Replace with your actual API call to get the status code

    if (statusCode == 200) {
      emit(LoginSuccess()); // Successful login
    } else {
      emit(LoginError('There is an error')); // Error during login
    }
  }
}
