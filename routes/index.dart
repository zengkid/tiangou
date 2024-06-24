import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  print("calling index");

  return Response(body: 'Welcome to Dart Frog!');
}
