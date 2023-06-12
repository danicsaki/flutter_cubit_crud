import 'package:cubit_test/cubits/cubits.dart';
import 'package:cubit_test/models/models.dart';
import 'package:cubit_test/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';
  final String title;

  const HomeScreen({super.key, required this.title});

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const HomeScreen(title: ''),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          PetsCubit(repository: RepositoryProvider.of<PetsRepository>(context))
            ..getPets(),
      child: const PetListView(),
    );
  }
}

class PetListView extends StatelessWidget {
  const PetListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Pet? selected;
    return Scaffold(
      appBar: AppBar(title: const Text('Pets List')),
      body: Column(
        children: [
          TextButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: const Text('Login')),
          BlocConsumer<PetsCubit, PetState>(
            listener: (context, state) {
              if (state.status == PetStateStatus.success) {
                if (state.exception != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.exception!.message)),
                  );
                }
              } else if (state.status == PetStateStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${state.exception}')),
                );
              }
            },
            builder: (context, state) {
              return BlocBuilder<PetsCubit, PetState>(
                builder: (context, state) {
                  switch (state.status) {
                    case PetStateStatus.loading:
                      return const Center(child: CircularProgressIndicator());
                    case PetStateStatus.initial:
                    case PetStateStatus.success:
                      return SizedBox(
                        height: 600,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          shrinkWrap: true,
                          itemCount: state.pets.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              selected = state.pets[index];
                              debugPrint('$selected');
                            },
                            child: ListTile(
                              title: Text(state.pets[index].name),
                              subtitle: Text(state.pets[index].description),
                            ),
                          ),
                        ),
                      );
                    case PetStateStatus.failure:
                      return Center(
                        child: Text(state.exception!.message.toString()),
                      );
                  }
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const SizedBox(height: 5),
          // FloatingActionButton(
          //   child: const Icon(Icons.delete),
          //   onPressed: () => context.read<PetsCubit>().deletePet(selected!.id!),
          // ),
          const SizedBox(height: 5),
          // FloatingActionButton(
          //     child: const Icon(Icons.pets),
          //     onPressed: () {
          //       context.read<PetsCubit>().updatePet(selected!.id!, selected!);
          //     }),
          const SizedBox(height: 5),
          // FloatingActionButton(
          //   child: const Icon(Icons.add),
          //   onPressed: () => context.read<PetsCubit>().addPet(selected!),
          // ),
          const SizedBox(height: 5),
          // FloatingActionButton(
          //   child: const Icon(Icons.refresh),
          //   onPressed: () => context.read<PetsCubit>().getPets(),
          // ),
        ],
      ),
    );
  }
}
