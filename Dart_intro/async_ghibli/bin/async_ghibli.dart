import 'package:async_ghibli/services/ghibli_api_service.dart';
import 'package:async_ghibli/models/film.dart';

void main(List<String> arguments) async {
  var jsonFilm = await getFilmById('58611129-2dbc-4a81-a72f-77ddfc1b1b49');
  var film = Film.fromJson(jsonFilm);
  print(film);
}
