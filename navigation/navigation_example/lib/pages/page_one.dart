import 'package:flutter/material.dart';
import 'package:navigation_example/pages/page_two.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('PAGE ONE'),
            ElevatedButton(
              onPressed: () {
                // When I press this button I want to route to page two
                // We'll start with using the material page route manual push
                // Though it is generally better to use pushNamed with centralized routing
                Navigator.of(context).push(
                  // Material Page Route is a special widget that calls a builder function to create a page
                  // And can be used for routing
                  MaterialPageRoute(builder: (context) => PageTwo()),
                );
              },
              child: Text('Go To Page Two'),
            ),
            Text('DATA FROM PAGE TWO GOES HERE'),
          ],
        ),
      ),
    );
  }
}
