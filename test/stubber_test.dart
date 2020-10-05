import 'dart:collection';
import 'package:flutter_gherkin_addons/stubber.dart';
import 'package:test/test.dart';

void main() {
  group('Stubber', () {
    test('toKey() returns correct key value', () {
      var expected = 'GET:http://myuri.com';
      var testStub = Stub('GET', 'http://myuri.com', (request) {
        return Response(200, '', headers: {'Content-Type': 'application/json'});
      });
      var actual = testStub.toKey();
      expect(actual, expected);
    });
  });

  group('RequestMatcher find', () {
    test('returns null when unable to find a match for the given key', () {
      var stub = Stub('GET', 'http://myuri.com', (request) {
        return Response(200, '', headers: {'Content-Type': 'application/json'});
      });

      HashMap<String, Stub> stubs = new HashMap<String, Stub>();
      stubs[stub.toKey()] = stub;

      Stub actual = RequestMatcher.find('unknown-key', stubs);
      expect(actual, isNull);
    });

    test('returns the appropriate stub when a single match is found for the given key', () {
      var expectedStub = Stub('GET', 'http://myuri.com', (request) {
        return Response(200, '', headers: {'Content-Type': 'application/json'});
      });

      HashMap<String, Stub> stubs = new HashMap<String, Stub>();
      stubs[expectedStub.toKey()] = expectedStub;

      Stub actualStub = RequestMatcher.find(expectedStub.toKey(), stubs);
      expect(actualStub, expectedStub);
    });
  });
}
