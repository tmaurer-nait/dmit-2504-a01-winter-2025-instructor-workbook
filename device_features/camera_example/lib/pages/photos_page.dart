import 'package:flutter/material.dart';

import 'dart:io';

// flutter pub add path_provider
import 'package:path_provider/path_provider.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({super.key});

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  var photosDir = '';
  List<String> photos = [];

  @override
  void initState() {
    super.initState();
    // get the cache folder where I saved my photos to
    getApplicationCacheDirectory().then((dir) {
      setState(() {
        // Save the cache location
        photosDir = dir.path;

        // for each file in cache, if it's a jpg save that file path to photos
        dir.listSync().toList().forEach((file) {
          if (file.path.endsWith('jpg')) photos.add(file.path);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, idx) {
          return ListTile(
            leading: Image.file(File(photos[idx]), height: 50, width: 50),
            title: Text(photos[idx]),
          );
        },
        itemCount: photos.length,
      ),
    );
  }
}
