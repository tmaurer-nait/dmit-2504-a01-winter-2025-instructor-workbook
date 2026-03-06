// flutter pub add flutter_bloc
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_example/models/user.dart';

// In theory we could just use our user class as the state like we did in riverpod
// However imagine we want to track more info realted to the user (isLoading, errorMessage, etc)
// In that case we could wrap our User class in a UserState that holds the User and that extra info
class UserState {
  UserState(User user) {
    _user = user;
    // Here we could add those extra properties (isLoading, etc.)
  }

  // Again no setter for immutability
  late final User _user;
  User get user => _user;
}

// We have our UserState class now let's make a Cubit that will emit those states
// Essentially a stream of UserStates
class UserCubit extends Cubit<UserState> {
  // Cubits need 2 things, a state and functions that emit new states

  // We initialize the Cubit's state with a default user
  UserCubit() : super(UserState(User('Pauline', 'Dude')));

  // public method that emits new user states (replacing the current one)
  void updateUser(User user) {
    // emit is built into the cubit class and sends the next state down the stream
    return emit(UserState(user));
  }
}
