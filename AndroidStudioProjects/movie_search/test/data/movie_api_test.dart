import 'package:flutter_test/flutter_test.dart';
import 'package:movie_search/data/movie_api_data.dart';

void main() {
  test('movie api 테스트합니다.', () async {
    final MovieApi api = MovieApi();

    final result = await api.fetchPhotos();
    expect(result.length, 20);
  });
}
