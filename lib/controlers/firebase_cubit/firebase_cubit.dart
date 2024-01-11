import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../firestore_repo.dart';
part 'firebase_state.dart';

class FirebaseCubit extends Cubit<FirebaseState> {
  FirebaseCubit() : super(FirebaseInitial());
  Future addUser({required String users}) async {
    emit(FirebaseLoading());
    print('Loading');
    final user = await FirestoreRepo.createUser(users: users);
    print(user);
    if (user == 200) {
      print("Loaded");
      emit(FirebaseLoaded());
    } else {
      emit(FirebaseError());
    }
  }
}
