import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:tiangou/music/service.dart';

Response onRequest(RequestContext context) {
  // var musicService = context.read<MusicService>();
  var musicService = MusicService();
  var scanning = musicService.inprogress;
  if (!scanning) {
    // musicService.inprogress = true;
    musicService.scanMusic();
  }
  print('scanning = $scanning');
  return Response(
      encoding: utf8,
      headers: {HttpHeaders.contentTypeHeader: 'text/json;charset=utf-8'},
      body: 'scanning:$scanning');
}
