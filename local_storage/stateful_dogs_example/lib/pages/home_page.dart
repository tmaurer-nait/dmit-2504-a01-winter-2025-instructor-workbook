import 'package:flutter/material.dart';

import 'package:stateful_dogs_example/widgets/dog_image.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dog Rating App')),
      body: Center(child: DogImage()),
    );
  }
}
