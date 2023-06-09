import 'package:cubit_test/cubits/pets/pets_cubit.dart';
import 'package:cubit_test/models/pet_model.dart';
import 'package:cubit_test/repositories/pets/pets_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PetsRepository>(
            create: (context) => PetsRepository()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      body: BlocConsumer<PetsCubit, PetState>(
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
                  return ListView.builder(
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
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.delete),
            onPressed: () => context.read<PetsCubit>().deletePet(selected!.id!),
          ),
          const SizedBox(height: 5),
          FloatingActionButton(
              child: const Icon(Icons.pets),
              onPressed: () {
                context.read<PetsCubit>().updatePet(selected!.id!, selected!);
              }),
          const SizedBox(height: 5),
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => context.read<PetsCubit>().addPet(selected!),
          ),
          const SizedBox(height: 5),
          FloatingActionButton(
            child: const Icon(Icons.refresh),
            onPressed: () => context.read<PetsCubit>().getPets(),
          ),
        ],
      ),
    );
  }
}
