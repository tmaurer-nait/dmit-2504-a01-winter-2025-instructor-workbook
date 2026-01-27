import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DogImage extends StatefulWidget {
  const DogImage({super.key});

  final endpoint = 'https://dog.ceo/api/breeds/image/random';

  @override
  State<DogImage> createState() => _DogImageState();
}

class _DogImageState extends State<DogImage> {
  // Create state variables
  var _dogImageURL = '';

  // Helper function that makes a fetch request to dog.ceo
  Future<String> getRandomDogURL() async {
    // Parse the URL
    final endpointURI = Uri.parse(widget.endpoint);

    // Make the get request and await the result
    final res = await http.get(endpointURI);

    // Decode the body and return
    return jsonDecode(res.body)['message'];
  }

  void getNewDog() {
    // Fetch a dog from the URL
    setState(() {
      _dogImageURL = '';
    });
    getRandomDogURL().then((newImageUrl) {
      // Make sure to call setState to trigger redraw
      setState(() {
        // Load the dog into the state
        _dogImageURL = newImageUrl;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    getNewDog();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // This conditional render prevents exceptions while waiting on load
        _dogImageURL == ''
            ? CircularProgressIndicator()
            : Image.network(_dogImageURL, height: 500),
        ElevatedButton(
          onPressed: () {
            getNewDog();
          },
          child: Text('Fetch New Dog'),
        ),
      ],
    );
  }
}
