import 'dart:async';
import 'package:http/http.dart' as http;

class MockClient extends http.BaseClient {
  final MockClientHandler _handler;

  MockClient(this._handler);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final response = await _handler(request);

    // Convert http.Response to http.StreamedResponse
    return http.StreamedResponse(
      Stream.fromIterable([response.bodyBytes]),
      response.statusCode,
      contentLength: response.contentLength,
      request: request,
    );
  }
}

typedef MockClientHandler = Future<http.Response> Function(http.BaseRequest request);
