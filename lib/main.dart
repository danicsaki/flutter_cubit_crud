import 'package:cubit_test/config/app_routes.dart';
import 'package:cubit_test/cubits/cubits.dart';
import 'package:cubit_test/firebase_options.dart';
import 'package:cubit_test/repositories/pets/pets_repository.dart';
import 'package:cubit_test/repositories/user/user_repository.dart';
import 'package:cubit_test/screens/home/home_screen.dart';
import 'package:cubit_test/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var fcm = await FirebaseMessaging.instance.getToken();
  debugPrint(fcm);
  runApp(const MyApp());
  debugPrint(fcm);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PetsRepository>(
            create: (context) => PetsRepository()),
        RepositoryProvider<UserRepository>(
            create: (context) => UserRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserCubit(
              repository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => NotificationCubit()..initialize(),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: HomeScreen.routeName,
        ),
      ),
    );
  }
}
