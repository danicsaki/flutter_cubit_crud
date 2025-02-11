import 'package:cubit_test/cubits/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => LoginScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Username:',
              style: TextStyle(fontSize: 18),
            ),
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                hintText: 'Enter your username',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Password:',
              style: TextStyle(fontSize: 18),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Enter your password',
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    final username = usernameController.text;
                    final password = passwordController.text;
                    loginCubit.login(username, password);
                  },
                  child: state is LoginLoading
                      ? const Center(child: CircularProgressIndicator())
                      : const Text('Login'),
                );
              },
            ),
            const SizedBox(height: 16),
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeNewScreen(),
                    ),
                  );
                } else if (state is LoginError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Login failed. Please try again.'),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomeNewScreen extends StatelessWidget {
  static const String routeName = '/home';

  const HomeNewScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const HomeNewScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}
