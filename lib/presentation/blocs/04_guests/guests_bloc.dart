import 'package:bloc/bloc.dart';
import 'package:blocs_app/config/config.dart';
import 'package:blocs_app/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'guests_event.dart';
part 'guests_state.dart';

const uuid = Uuid();

class GuestsBloc extends Bloc<GuestsEvent, GuestsState> {
  GuestsBloc()
      : super(GuestsState(guests: [
          Todo(
            id: uuid.v4(),
            description: RandomGenerator.getRandomName(),
            completedAt: null,
          ),
          Todo(
            id: uuid.v4(),
            description: RandomGenerator.getRandomName(),
            completedAt: null,
          ),
          Todo(
            id: uuid.v4(),
            description: RandomGenerator.getRandomName(),
            completedAt: DateTime.now(),
          ),
          Todo(
            id: uuid.v4(),
            description: RandomGenerator.getRandomName(),
            completedAt: null,
          ),
          Todo(
            id: uuid.v4(),
            description: RandomGenerator.getRandomName(),
            completedAt: DateTime.now(),
          ),
          Todo(
            id: uuid.v4(),
            description: RandomGenerator.getRandomName(),
            completedAt: null,
          ),
          Todo(
            id: uuid.v4(),
            description: RandomGenerator.getRandomName(),
            completedAt: null,
          ),
        ])) {
    on<SetCustomfilterEvent>((event, emit) {
      emit(state.copyWith(filter: event.newFilter));
    });

    on<AddGuest>(_addGuestHandler);

    on<ToggleGuest>(_toggleGuestHandler);
  }

  void changeFilter(GuestFilter newFilter) {
    add(SetCustomfilterEvent(newFilter: newFilter));
  }

  void addGuest(String description) {
    add(AddGuest(description: description));
  }

  void _addGuestHandler(AddGuest event, Emitter<GuestsState> emit) {
    final newGuest = Todo(
      id: uuid.v4(),
      description: event.description,
      completedAt: null,
    );
    emit(state.copyWith(guests: [...state.guests, newGuest]));
  }

  void toggleGuest(String id) {
    add(ToggleGuest(id: id));
  }

  void _toggleGuestHandler(ToggleGuest event, Emitter<GuestsState> emit) {
    final newGuest = state.guests.map((guest) {
      if (guest.id == event.id) {
        return guest.copyWith(completedAt: guest.done ? null : DateTime.now());
      }
      return guest;
    }).toList();

    emit(state.copyWith(guests: newGuest));
  }
}
