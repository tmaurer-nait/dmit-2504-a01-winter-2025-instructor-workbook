import 'package:flutter/material.dart';

import 'pages/home_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_example/state/user_cubit.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // wrap our entire app in a bloc provider so that user cubit
    // is accessible in the entire widget tree
    return BlocProvider(
      // Here we create the initial state that is passed into the tree
      // Extremely similar to provider syntax
      create: (context) => UserCubit(),
      child: const MaterialApp(
        home: Scaffold(body: Center(child: HomePage())),
      ),
    );
  }
}
