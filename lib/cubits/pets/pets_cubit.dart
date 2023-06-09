import 'package:bloc/bloc.dart';
import 'package:cubit_test/models/failure_model.dart';
import 'package:cubit_test/models/pet_model.dart';
import 'package:cubit_test/repositories/pets/pets_repository.dart';
import 'package:equatable/equatable.dart';

part 'pets_state.dart';

class PetsCubit extends Cubit<PetState> {
  final PetsRepository repository;
  PetsCubit({required this.repository}) : super(const PetState());

  Future<void> getPets() async {
    emit(state.copyWith(status: PetStateStatus.loading));

    final response = await repository.getPets();

    if (response is List<Pet>) {
      emit(
        state.copyWith(
          status: PetStateStatus.success,
          pets: response,
        ),
      );
    } else {
      emit(state.copyWith(
        status: PetStateStatus.failure,
        exception: response,
      ));
    }
  }

  Future<void> addPet(Pet pet) async {
    emit(state.copyWith(status: PetStateStatus.loading));

    final response = await repository.addPet(pet) as Failure;

    emit(
      state.copyWith(
        status: PetStateStatus.success,
        exception: response,
      ),
    );

    getPets();
  }

  Future<void> updatePet(String id, Pet pet) async {
    emit(state.copyWith(status: PetStateStatus.loading));

    final response = await repository.updatePet(id, pet) as Failure;

    emit(
      state.copyWith(
        status: PetStateStatus.success,
        exception: response,
      ),
    );

    getPets();
  }

  Future<void> deletePet(String id) async {
    emit(state.copyWith(status: PetStateStatus.loading));

    final response = await repository.deletePet(id) as Failure;

    emit(
      state.copyWith(
        status: PetStateStatus.success,
        exception: response,
      ),
    );

    getPets();
  }
}
