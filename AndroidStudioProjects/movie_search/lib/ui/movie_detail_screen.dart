import 'package:flutter/material.dart';
import 'package:movie_search/model/movies_all_data.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieInfo movieInfo;

  const MovieDetailScreen({Key? key, required this.movieInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(movieInfo.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  movieInfo.title,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Image.network(movieInfo.posterUrl),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(movieInfo.releaseDate.toString()),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Row(
                                children: [
                                  const Icon(Icons.check),
                                  const SizedBox(width: 8),
                                  Text(movieInfo.voteCount.toString()),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {},
                              child: Row(
                                children: [
                                  const Icon(Icons.star),
                                  const SizedBox(width: 8),
                                  Text(movieInfo.voteAverage.toString()),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(movieInfo.overview),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
