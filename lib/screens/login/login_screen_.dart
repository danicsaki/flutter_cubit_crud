import 'dart:async';

import 'package:cubit_test/cubits/cubits.dart';
import 'package:cubit_test/models/models.dart';
import 'package:cubit_test/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  bool? loading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => LoginScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: widget.emailController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter Your Name',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: widget.passwordController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter Your Password',
            ),
          ),
          const SizedBox(height: 10),
          CustomElevatedButton(
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              setState(() {
                widget.loading = true;
              });
              context
                  .read<UserCubit>()
                  .login(widget.emailController.text,
                      widget.passwordController.text)
                  .then((value) {
                Timer(const Duration(seconds: 2), () {
                  if (value is User) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/dashboard', (Route<dynamic> route) => false);
                  } else {
                    Failure failure = value;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(failure.message),
                      ),
                    );
                    setState(() {
                      widget.loading = false;
                    });
                  }
                });
              });
            },
            beginColor: Colors.white,
            endColor: Colors.white,
            child: widget.loading!
                ? const CircularProgressIndicator()
                : Text(
                    'LOGIN',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
          ),
        ],
      ),
    );
  }
}
