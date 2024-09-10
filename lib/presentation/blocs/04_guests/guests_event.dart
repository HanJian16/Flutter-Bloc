part of 'guests_bloc.dart';

sealed class GuestsEvent extends Equatable {
  const GuestsEvent();

  @override
  List<Object> get props => [];
}

final class SetAllFilterEvent extends GuestsEvent {}

final class SetInvitedFilterEvent extends GuestsEvent {}

final class SetNotInvitedFilterEvent extends GuestsEvent {}

final class SetCustomfilterEvent extends GuestsEvent {
  final GuestFilter newFilter;

  const SetCustomfilterEvent({required this.newFilter});
}

final class AddGuest extends GuestsEvent {
  final String description;

  const AddGuest({required this.description});
}

final class ToggleGuest extends GuestsEvent {
  final String id;

  const ToggleGuest({required this.id});
}
