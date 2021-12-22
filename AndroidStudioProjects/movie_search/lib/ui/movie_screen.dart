import 'package:flutter/material.dart';
import 'package:movie_search/data/movie_api_data.dart';
import 'package:movie_search/model/movies_all_data.dart';
import 'package:movie_search/ui/movie_detail_screen.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  TextEditingController _textEditingController = TextEditingController();

  List<MovieInfo> _movies = [];
  final _api = MovieApi();

  @override
  void initState() {
    _textEditingController.addListener(() {
      print(_textEditingController.text);
    });
    // print('뭐가 들어갔나?: ${_api.fetchPhotos()}');
    super.initState();
    _showResult();
  }

  Future<void> _showResult() async {
    List<MovieInfo> movies = await _api.fetchPhotos();
    setState(() {
      _movies = movies;
      // print('_movies 확인 : ${_movies?.results}');
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<MovieInfo> matchKeyword = [];

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("영화 정보 검색기"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: _movies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 260,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 7,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailScreen(
                                  movieInfo: _movies[index],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0.5,
                                  blurRadius: 9,
                                ),
                              ],
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  _movies[index].posterUrl,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            _movies[index].title,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
