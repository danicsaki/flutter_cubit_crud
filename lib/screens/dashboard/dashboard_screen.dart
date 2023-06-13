import 'package:cubit_test/cubits/cubits.dart';
import 'package:cubit_test/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = '/dashboard';
  final String title;

  const DashboardScreen({super.key, required this.title});

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const DashboardScreen(title: ''),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => PetsCubit(
            repository: RepositoryProvider.of<PetsRepository>(context))
          ..getPets(),
        child: Scaffold(
          body: Center(
            child: BlocBuilder<NotificationCubit, String>(
              builder: (context, state) {
                return Text(state);
              },
            ),
          ),
        ));
  }
}
