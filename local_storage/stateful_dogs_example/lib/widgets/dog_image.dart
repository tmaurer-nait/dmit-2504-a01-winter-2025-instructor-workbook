import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// flutter pub add path_provider
import 'package:path_provider/path_provider.dart';
import 'dart:io';

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

      // Save the fetched image
      _saveImage(newImageUrl);

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

    // Check if we can load a local image
    // if so load it, else fetch new one

    // Get the temp directory
    getTemporaryDirectory().then((dir) {
      // Try to open the file
      final file = File('${dir.path}/lastDogImage.jpg');
      // If Openable load that file
      if (file.existsSync()) {
        setState(() {
          _dogImageURL = '${dir.path}/lastDogImage.jpg';
        });
      } else {
        // Else get new dog
        getNewDog();
      }
    });
  }

  // This function takes in an image url, fetches the data from that url
  // and saves the data to a file
  void _saveImage(String url) async {
    // Fetch the image and await the response
    final res = await http.get(Uri.parse(url));

    // Get the temp directory
    final dir = await getTemporaryDirectory();

    // Create the file path
    final filePath = '${dir.path}/lastDogImage.jpg';

    // Open the file
    final file = File(filePath);

    // Write to the file
    file.writeAsBytesSync(res.bodyBytes);
  }

  Widget _buildImage() {
    // We now need to check on the state of the image. There are 3 cases:
    // 1. Empty image URL -> show loading spinner
    // 2. Local image loaded from file -> Image.file
    // 3. Network image loaded online -> Image.network

    // This will store the reference to whatever needs to be shown
    late Widget childWidget;

    if (_dogImageURL.trim().isEmpty) {
      childWidget = CircularProgressIndicator();
    } else if (_dogImageURL.startsWith('http')) {
      childWidget = Image.network(_dogImageURL, height: 600);
    } else {
      childWidget = Image.file(File(_dogImageURL), height: 600);
    }

    // This conditional render prevents exceptions while waiting on load
    return _dogImageURL == ''
        ? SizedBox(height: 600, child: Center(child: childWidget))
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
            child: childWidget,
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
