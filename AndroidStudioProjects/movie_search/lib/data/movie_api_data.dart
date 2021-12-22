import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_search/model/movies_all_data.dart';

class MovieApi {
  Future<List<MovieInfo>> fetchPhotos() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=a64533e7ece6c72731da47c9c8bc691f&language=ko-KR&page=1'));
    if (response.statusCode == 200) {
      List jsonToMap = jsonDecode(response.body)['results'];
      // print('이것은 jsonToMap${jsonToMap}');
      // print(jsonList.map((e) => MovieModel.fromJson(e)).toList());
      return jsonToMap.map((e) => MovieInfo.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load Movie');
    }
  }
}
