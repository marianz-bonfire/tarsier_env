import 'package:tarsier_env/tarsier_env.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () async {
    final env = await loadEnvFile('.env');

    //print('APP_KEY: ${env.APP_KEY}');
    //print('URL: ${env.URL}');

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      //expect(env.isAwesome, isTrue);
    });
  });
}
