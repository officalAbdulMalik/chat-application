import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserCubit extends Cubit<bool> {
  AddUserCubit(super.initialState);
  userAdded({required bool index}) {
    emit(index);
  }
}
