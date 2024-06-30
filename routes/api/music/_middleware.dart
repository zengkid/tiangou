import 'package:dart_frog/dart_frog.dart';
import 'package:tiangou/music/service.dart';

MusicService? _musicService;

Handler middleware(Handler handler) {
  return handler
      .use(provider<MusicService>((_) => _musicService ??= MusicService()));
  // return handler;
}
