import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'model/data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Data> _data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '요소수 주유소 현황',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                fetchData();
              },
              child: const Text('가져오기'),
            ),
          ),
          Expanded(
            child: ListView(
              children: _data.map(
                (e) {
                  return ListTile(
                    title: Text(e.name ?? '이름없음'),
                    subtitle: Text(e.addr ?? '주소없음'),
                    trailing: Text(e.inventory ?? '재고없음'),
                    onTap: () {
                      launch('tel:+${e.tel}');
                    },
                  );
                },
              ).toList(),
            ),
          )
        ],
      ),
    );
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
      'http://api.odcloud.kr/api/uws/v1/inventory?page=10&perPage=50&serviceKey=data-portal-test-key&=',
    );
    var response = await http.get(url);
    final jsonResult = jsonDecode(response.body);
    final jsonData = jsonResult['data'];

    setState(() {
      _data.clear();
      jsonData.forEach((e) {
        _data.add(Data.fromJson(e));
      });
    });
    // print('statusCode Print ${response.statusCode}');
    // print('body Print ${response.body}');
    print('fatch completed');
  }
}
