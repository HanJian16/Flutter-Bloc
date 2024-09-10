import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final Future<String> Function(int id) _fetchPokemonName;

  PokemonBloc({
    required Future<String> Function(int id) fetchPokemon,
  })  : _fetchPokemonName = fetchPokemon,
        super(const PokemonState()) {
    on<PokemonAdded>((event, emit) {
      final newPokemons = Map<int, String>.from(state.pokemons);
      newPokemons[event.id] = event.name;
      emit(state.copyWith(pokemons: newPokemons));
    });
  }

  Future<String> fetchPokemons(int id) async {
    if (state.pokemons.containsKey(id)) {
      return state.pokemons[id]!;
    }

    try {
      final pokemon = await _fetchPokemonName(id);
      add(PokemonAdded(id: id, name: pokemon));
      return pokemon;
    } catch (e) {
      throw Exception('No se pudo obtener el nombre del pokemon');
    }
  }
}
