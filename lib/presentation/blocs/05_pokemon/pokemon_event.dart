part of 'pokemon_bloc.dart';

sealed class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object> get props => [];
}

class PokemonAdded extends PokemonEvent {
  final int id;
  final String name;

  const PokemonAdded({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}
