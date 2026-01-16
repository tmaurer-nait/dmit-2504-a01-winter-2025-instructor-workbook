import 'dart:convert';
import 'package:http/http.dart' as http;

const endpoint = 'https://ghibliapi.vercel.app/films/';

// Fetches a ghibli film given an id, and returns a decoded json representing that film
Future<dynamic> getFilmById(String id) async {
  // Error handling for any other issues
  try {
    // Parse the endpoint URI
    var uri = Uri.parse('$endpoint$id');

    // Fetch the data from the endpoint
    var response = await http.get(uri);

    // Error handling for status codes
    if (response.statusCode != 200) {
      throw Exception("Something went wrong: ${response.statusCode} received");
    }

    // decode the response
    var jsonFilm = jsonDecode(response.body);

    // return the decoded json
    return jsonFilm;
  } catch (e) {
    throw Exception("Something went wrong: $e");
  }
}
