import 'package:flutter_bloc/flutter_bloc.dart';

class UserNameCubit extends Cubit<String> {
  UserNameCubit() : super('no-username');

  void setUserName(String username) {
    emit(username);
  }
}
