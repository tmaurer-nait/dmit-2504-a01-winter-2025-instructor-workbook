import 'package:flutter/material.dart';
import 'package:navigation_example/constants/routes.dart' as routes;

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  // This variable will hold the info returned from page two
  var data = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('PAGE ONE'),
            ElevatedButton(
              // We made this async so we can "listen" for a response from page two
              // Navigator.push() resolves when the page it pushed is popped from the stack
              onPressed: () async {
                // When I press this button I want to route to page two
                // We'll start with using the material page route manual push
                // Though it is generally better to use pushNamed with centralized routing
                // Navigator.of(context).push(
                //   // Material Page Route is a special widget that calls a builder function to create a page
                //   // And can be used for routing
                //   MaterialPageRoute(builder: (context) => PageTwo()),
                // );
                final returnValue = await Navigator.of(
                  context,
                ).pushNamed(routes.pageTwoRoute);

                setState(() {
                  // We use this null check in case the user presses the back button (no data)
                  // instead of our custom back button that actually returns data
                  data = returnValue != null ? returnValue as String : '';
                });
              },
              child: Text('Go To Page Two'),
            ),
            Text(data.isEmpty ? 'Awaiting Response....' : data),
          ],
        ),
      ),
    );
  }
}
