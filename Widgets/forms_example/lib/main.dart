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

  String? _isEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password Cannot Be Empty';
    }
    return null;
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
            // Validator takes a callback function that returns either a
            // string or null. If String it's an error, if null it's valid
            validator: (value) => (value == null || value.trim().isEmpty)
                ? 'Username Cannot Be Empty'
                : null,
          ),
          TextFormField(
            // Password fields should have the following properties to
            // hide the text and prevent suggestions/autocomplete
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(label: Text('Password')),
            controller: _passwordController,
            validator: _isEmpty,
          ),
          TextFormField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(label: Text('Confirm Your Password')),
            controller: _password2Controller,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Password cannot be empty';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              // This is where we validate and then submit
              // There are two ways of accessing the form
              // Firstly you can do Form.of(context)

              // Secondly see below
              if (_formKey.currentState!.validate()) {
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
              }
            },
            child: Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
