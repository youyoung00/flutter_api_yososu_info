import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_search_rewind/model/album.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String keyword = 'iphone';

  final TextEditingController _controller = TextEditingController();

  Future<List<Album>> fetchAlbums() async {
    final response = await http.get(Uri.parse(
        'https://pixabay.com/api/?key=24806198-1f9550a3fd92fcce8b0067dc7&q=$keyword&image_type=photo&pretty=true'));
    print('response 확인 : ${response.body}');
    if (response.statusCode == 200) {
      final List<Album> myFutureAlbums =
          Album.listToAlbums(jsonDecode(response.body)['hits']);
      print('jsonDecode 확인 : ${myFutureAlbums.toString()}');
      return myFutureAlbums;
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    _controller.addListener(() {
      print(_controller.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Network Sample"),
      ),
      body: Column(
        children: [
          Form(
            child: TextFormField(
              controller: _controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                icon: TextButton(
                  onPressed: () {
                    if (_controller.text == null) {
                      AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        title: Column(
                          children: const <Widget>[
                            Text("Dialog Title"),
                          ],
                        ),
                      );
                    } else {
                      setState(() {
                          keyword = _controller.text;
                        },
                      );
                    }
                  },
                  child: const Text('검색'),
                ),
              ),
            ),
          ),
          FutureBuilder<List<Album>>(
            future: fetchAlbums(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('네트워크 에러!'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: Text('데이터가 없습니다'),
                );
              }
              final List<Album> albums = snapshot.data!;
              return _buildAlbums(albums);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAlbums(List<Album> albums) {
    return Expanded(
      child: ListView.builder(
        itemCount: albums.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: 180,
                  height: 100,
                  child: Image.network(
                    albums[index].previewURL,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(albums[index].tags)
              ],
            ),
          );
        },
      ),
    );
  }
}
