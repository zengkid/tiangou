import 'dart:io';
import 'package:taggy/taggy.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:tiangou/music/service.dart';

Future<void> init(InternetAddress ip, int port) async {
  print("init....");
  Taggy.initializeFrom(getTaggyDylibFromDirectory('.'));
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  // 1. Execute any custom code prior to starting the server...

  // 2. Use the provided `handler`, `ip`, and `port` to create a custom `HttpServer`.
  // Or use the Dart Frog serve method to do that for you.

  // port = 81;
  ip = InternetAddress.anyIPv4;

  print("run....");

  // var newH =
  //     handler.use(provider<MusicService>((context) => MusicService()));

  final server = serve(handler, ip, port);

  return server;
}
