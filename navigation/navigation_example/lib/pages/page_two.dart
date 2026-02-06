import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // If you put an appBar and utilize routing, it will add a back button to the appBar for you
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('PAGE TWO'),
            FilledButton(
              onPressed: () {
                // To return to page one from page two we just pop() the stack
                // This makes it a back button
                // If I give an argument to pop() it will return that to the place where this page was pushed from
                Navigator.of(context).pop('You left page two');
              },
              child: Text('Go Back to Page One'),
            ),
          ],
        ),
      ),
    );
  }
}
