import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_example/models/user.dart';
import 'package:bloc_example/state/user_cubit.dart';

class FirstNamePage extends StatelessWidget {
  const FirstNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Name Page')),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 24.0),
            // Bloc builder is similar to listenable builder
            // Whenever the cubit/bloc that it listens to emits a new state it calls
            // the builder function with that new state and draws the returned widget
            // needs to know the subtypes of the cubit it listens to and the state that cubit emits
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return Text(
                  'Username: ${state.user.firstName} ${state.user.lastName}',
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Update our user first name here
        onPressed: () {
          // get the cubit from the bloc provider using inherited widget syntax
          final cubit = BlocProvider.of<UserCubit>(context);

          // Create a new user (with the old state's lastname)
          final newUser = User('Joe', cubit.state.user.lastName);

          // emit the new user state by calling updateUser
          cubit.updateUser(newUser);
        },
        child: const Icon(Icons.update),
      ),
    );
  }
}
