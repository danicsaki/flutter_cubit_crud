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

  // @override
  // Widget build(BuildContext context) {
  //   return MultiBlocProvider(
  //     providers: [
  //       BlocProvider<PetsCubit>(
  //         create: (BuildContext context) => PetsCubit(PetsRepository()),
  //       ),
  //     ],
  //     child: MaterialApp(
  //       title: 'Flutter Demo',
  //       theme: ThemeData(
  //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  //         useMaterial3: true,
  //       ),
  //       home: const MyHomePage(title: 'Flutter Demo Home Page'),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PetsRepository(),
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
    // context.read<PetsCubit>().getPets();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(
  //         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  //         title: Text(widget.title),
  //       ),
  //       body: SingleChildScrollView(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             BlocBuilder<PetsCubit, PetsState>(
  //               builder: (context, state) {
  //                 if (state is PetsLoading || state is PetsInitial) {
  //                   return const Center(child: CircularProgressIndicator());
  //                 } else if (state is PetsLoaded) {
  //                   // return Text(state.pets.toString());
  //                   return ListView.builder(
  //                       itemCount: state.pets.length,
  //                       shrinkWrap: true,
  //                       itemBuilder: (context, index) {
  //                         return Text(state.pets[index].name);
  //                       });
  //                 } else {
  //                   return const Text('Something whent wrong');
  //                 }
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //       floatingActionButton: Column(
  //         mainAxisAlignment: MainAxisAlignment.end,
  //         children: [
  //           FloatingActionButton(
  //             onPressed: () {
  //               context.read<PetsCubit>().addPet(
  //                     const Pet(
  //                       age: 4,
  //                       characteristics: 'new test',
  //                       coordinates: [0, 0],
  //                       description: 'new test',
  //                       image: 'new test',
  //                       name: 'new pet',
  //                       race: 'bulldog',
  //                       status: 'lost',
  //                       type: 'dog',
  //                     ),
  //                   );
  //             },
  //             child: const Text('add'),
  //           ),
  //           const SizedBox(
  //             height: 8,
  //           ),
  //           FloatingActionButton(
  //             onPressed: () {
  //               context.read<PetsCubit>().updatePet(
  //                     '637a484c84b3d68c8f10bccc',
  //                     const Pet(
  //                       age: 4,
  //                       characteristics: 'new edit',
  //                       coordinates: [0, 0],
  //                       description: 'new edit',
  //                       image: 'new edit',
  //                       name: 'new edit',
  //                       race: 'bulldog',
  //                       status: 'lost',
  //                       type: 'dog',
  //                     ),
  //                   );
  //             },
  //             child: const Text('update'),
  //           ),
  //           const SizedBox(
  //             height: 8,
  //           ),
  //           FloatingActionButton(
  //             onPressed: () {
  //               context.read<PetsCubit>().deletePet('637a484c84b3d68c8f10bccc');
  //             },
  //             child: const Text('delete'),
  //           ),
  //         ],
  //       ));
  // }

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
