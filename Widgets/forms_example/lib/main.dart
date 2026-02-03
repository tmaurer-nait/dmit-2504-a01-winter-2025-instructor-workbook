import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: UserSignupForm(),
        ),
      ),
    );
  }
}

// Create a form widget to hold the actual form data
// Make it stateful so we can uniquely identify the form and
// make updates as the values change. (use controllers)
class UserSignupForm extends StatefulWidget {
  const UserSignupForm({super.key});

  @override
  State<UserSignupForm> createState() => _UserSignupFormState();
}

class _UserSignupFormState extends State<UserSignupForm> {
  // Create a global key that uniquely identifies the form widget
  // That way we can access it later on for validation/reset purposes

  // Note: this is a GlobalKey<FormState> not
  // a GlobalKey<_userSignupFormState>
  final _formKey = GlobalKey<FormState>();

  // If we want to get the text out of our text fields we need to link
  // them to controllers
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _password2Controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The form widget allows us to validate/save/reset all fields at once
    return Form(
      // Connect this form to our global key
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'New User Sign Up Form',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          // The fields need to be FormFields so that they can link to the form
          TextFormField(
            decoration: InputDecoration(label: Text('Username')),
            controller: _usernameController,
          ),
          TextFormField(
            // Password fields should have the following properties to
            // hide the text and prevent suggestions/autocomplete
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(label: Text('Password')),
            controller: _passwordController,
          ),
          TextFormField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(label: Text('Confirm Your Password')),
            controller: _password2Controller,
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              // This is where we validate and then submit
              // TODO: Validate the form

              // If the form is valid display a snackbar. In the real world
              // This is where you'd make the API request or whatever you do.
              ScaffoldMessenger.of(
                context,
                // We will display the values the user entered instead
                // of doing anything productive with them
              ).showSnackBar(
                SnackBar(
                  content: Text(
                    'Username: ${_usernameController.text}, '
                    'Password: ${_passwordController.text}, '
                    'Password2: ${_password2Controller.text}',
                  ),
                ),
              );
            },
            child: Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
