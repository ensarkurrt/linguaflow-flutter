import 'dart:async';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'linguaflow_models.dart';

const defaultLinguaFlowRequestTimeout = Duration(seconds: 30);

Future<http.Response> sendSafeHttpRequest(
  http.Client client,
  String method,
  Uri uri, {
  required Map<String, String> headers,
  required int maxResponseBytes,
  String? body,
  Duration timeout = defaultLinguaFlowRequestTimeout,
}) async {
  final request = http.Request(method, uri)
    ..followRedirects = false
    ..headers.addAll(headers);
  if (body != null) request.body = body;
  final streamed = await client.send(request).timeout(timeout);
  if (streamed.isRedirect) {
    throw LinguaFlowException(
      'LinguaFlow redirects are not allowed',
      streamed.statusCode,
    );
  }
  final declaredLength = streamed.contentLength;
  if (declaredLength != null && declaredLength > maxResponseBytes) {
    throw LinguaFlowException('LinguaFlow response is too large', null);
  }
  final bytes = BytesBuilder(copy: false);
  await for (final chunk in streamed.stream.timeout(timeout)) {
    if (bytes.length + chunk.length > maxResponseBytes) {
      throw LinguaFlowException('LinguaFlow response is too large', null);
    }
    bytes.add(chunk);
  }
  return http.Response.bytes(
    bytes.takeBytes(),
    streamed.statusCode,
    request: streamed.request,
    headers: streamed.headers,
    isRedirect: streamed.isRedirect,
    persistentConnection: streamed.persistentConnection,
    reasonPhrase: streamed.reasonPhrase,
  );
}
