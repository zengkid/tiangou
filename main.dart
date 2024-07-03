import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:taggy/taggy.dart';
import 'package:tiangou/auth/repository.dart';
import 'package:tiangou/auth/user.dart';
import 'package:tiangou/music/service.dart';

Future<void> init(InternetAddress ip, int port) async {
  print("init....");
  Taggy.initializeFrom(getTaggyDylibFromDirectory('.'));

  // final userRepository = UserRepository();
  // var adminUser = await userRepository.findByUsername("admin");
  // if (adminUser == null) {
  //   adminUser = await userRepository.create(User("admin", "admin"));
  //   print("adminUser: ${adminUser.username}");
  // }
  // Isar.cl
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  // 1. Execute any custom code prior to starting the server...

  // 2. Use the provided `handler`, `ip`, and `port` to create a custom `HttpServer`.
  // Or use the Dart Frog serve method to do that for you.

  // port = 81;
  ip = InternetAddress.loopbackIPv4;

  return serve(handler, ip, port);
}
