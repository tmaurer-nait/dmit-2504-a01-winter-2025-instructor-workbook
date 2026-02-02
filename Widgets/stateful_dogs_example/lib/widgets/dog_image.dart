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
  var _likes = 0;
  var _dislikes = 0;

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
      // Include a mounted check to prevent weirdness
      if (!mounted) return;

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

  Widget _buildImage() {
    // This conditional render prevents exceptions while waiting on load
    return _dogImageURL == ''
        ? SizedBox(
            height: 600,
            child: Center(child: CircularProgressIndicator()),
          )
        : GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity != null &&
                  details.primaryVelocity! > 0) {
                setState(() {
                  _likes++;
                });
                getNewDog();
              } else {
                setState(() {
                  _dislikes++;
                });
                getNewDog();
              }
            },
            onDoubleTap: () {
              setState(() {
                _likes++;
              });
              getNewDog();
            },
            onLongPress: () {
              setState(() {
                _dislikes++;
              });
              getNewDog();
            },
            child: Image.network(_dogImageURL, height: 600),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildImage(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Likes: $_likes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Dislikes: $_dislikes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _likes++;
            });
            getNewDog();
          },
          child: Text('Like'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _dislikes++;
            });
            getNewDog();
          },
          child: Text('Dislike'),
        ),
      ],
    );
  }
}
