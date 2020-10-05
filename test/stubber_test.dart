import 'package:flutter_gherkin_addons/stubber.dart';
import 'package:test/test.dart';

void main() {
  test('toKey() returns correct key value', () {
    var expected = 'GET:http://myuri.com';
    var testStub = Stub('GET', 'http://myuri.com', (request) {
      return Response(200, '', headers: {'Content-Type': 'application/json'});
    });
    var actual = testStub.toKey();
    expect(actual, expected);
  });
}
