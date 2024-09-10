part of 'guests_bloc.dart';

enum GuestFilter {
  all,
  invited,
  notInvited,
}

class GuestsState extends Equatable {
  final GuestFilter filter;
  final List<Todo> guests;

  const GuestsState({
    this.filter = GuestFilter.all,
    this.guests = const [],
  });

  int get howManyGuests => guests.length;
  List<Todo> get filteredGuests {
    switch (filter) {
      case GuestFilter.all:
        return guests;
      case GuestFilter.invited:
        return guests.where((guest) => guest.done).toList();
      case GuestFilter.notInvited:
        return guests.where((guest) => !guest.done).toList();
      default:
        throw Exception('Filter value not suported');
    }
  }

  int get howManyFilteredGuests => filteredGuests.length;

  GuestsState copyWith({
    GuestFilter? filter,
    List<Todo>? guests,
  }) {
    return GuestsState(
      filter: filter ?? this.filter,
      guests: guests ?? this.guests,
    );
  }

  @override
  List<Object> get props => [filter, guests];
}
