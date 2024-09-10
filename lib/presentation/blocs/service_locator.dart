import 'package:blocs_app/config/config.dart';
import 'package:blocs_app/presentation/blocs/blocs.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void serviceLocatorInit() {
  getIt.registerSingleton<CounterCubit>(CounterCubit());
  getIt.registerSingleton<ThemeCubit>(ThemeCubit());
  getIt.registerSingleton<UserNameCubit>(UserNameCubit());
  getIt.registerSingleton<RouterSimpleCubit>(RouterSimpleCubit());

  getIt.registerSingleton<GuestsBloc>(GuestsBloc());
  getIt.registerSingleton<PokemonBloc>(PokemonBloc(
    fetchPokemon: PokemonInformation.getPokemonName,
  ));

  final historicLocationBloc =
      getIt.registerSingleton<HistoricLocationBloc>(HistoricLocationBloc());

  getIt.registerSingleton(GeolocationCubit(
    isLocationServiceEnabled: Geolocator.isLocationServiceEnabled,
    checkPermission: Geolocator.checkPermission,
    requestPermission: Geolocator.requestPermission,
    onNewUserLocation: historicLocationBloc.onNewUserLocation,
  )..watchuserlocation());
}
