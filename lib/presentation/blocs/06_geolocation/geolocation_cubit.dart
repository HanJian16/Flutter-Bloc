import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'geolocation_state.dart';

class GeolocationCubit extends Cubit<GeolocationState> {
  final Future<bool> Function() _isLocationServiceEnabled;
  final Future<LocationPermission> Function() _checkPermission;
  final Future<LocationPermission> Function() _requestPermission;
  final void Function((double, double) location)? onNewUserLocation;

  GeolocationCubit({
    required Future<bool> Function() isLocationServiceEnabled,
    required Future<LocationPermission> Function() checkPermission,
    required Future<LocationPermission> Function() requestPermission,
    this.onNewUserLocation,
  })  : _isLocationServiceEnabled = isLocationServiceEnabled,
        _checkPermission = checkPermission,
        _requestPermission = requestPermission,
        super(const GeolocationState());

  Future<void> checkStatus() async {
    //* Verificar Geolocation y permisos
    final serviceenabled = await _isLocationServiceEnabled();
    LocationPermission permissiongranted = await _checkPermission();

    if (permissiongranted == LocationPermission.denied) {
      permissiongranted = await _requestPermission();
    }

    final permission = permissiongranted == LocationPermission.always ||
        permissiongranted == LocationPermission.whileInUse;

    emit(
      state.copyWith(
        serviceEnabled: serviceenabled,
        permissionGranted: permission,
      ),
    );
  }

  Future<void> watchuserlocation() async {
    //* Correr la verificación de permisos y geolocation
    await checkStatus();

    //* Si no tenemos los permisos o el servicio no está habilitado, no correr el stream
    if (!state.permissionGranted || !state.serviceEnabled) return;

    //* Configuración de la geolocalización
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 15,
    );

    //* Correr el stream de geolocalización
    Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (position) {
        //todo: Aquí ya sabemos la ubicación del usuario.
        final newPosition = (position.latitude, position.longitude);
        emit(state.copyWith(location: newPosition));

        //* Sintaxis para llamar a una función si es que existe o no hacerlo si es nula.
        onNewUserLocation?.call(newPosition);
      },
    );
  }
}
