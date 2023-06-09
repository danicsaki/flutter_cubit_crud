part of 'pets_cubit.dart';

enum PetStateStatus { initial, loading, success, failure }

class PetState extends Equatable {
  final PetStateStatus status;
  final List<Pet> pets;
  final Failure? exception;

  const PetState(
      {this.status = PetStateStatus.initial,
      this.pets = const [],
      this.exception});

  PetState copyWith({
    PetStateStatus? status,
    List<Pet>? pets,
    Failure? exception,
  }) {
    return PetState(
      status: status ?? this.status,
      pets: pets ?? this.pets,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [status, pets, exception];
}
