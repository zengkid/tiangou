import 'dart:io';

import 'package:path/path.dart';
import 'package:taggy/taggy.dart';

class MusicService {
  bool inprogress = false;

  Future<void> scanMusic() async {
    print('starting scan');
    inprogress = true;
    var scanPath = r'Y:\Music\梁静茹[1999-2021]录音室专辑合集';
    var scanDir = Directory(scanPath);

    await scanMusics(scanDir);
    print("finished scan");
    inprogress = false;
  }

  Future<void> scanMusics(Directory dir) async {
    final files = dir.listSync(recursive: false, followLinks: true);
    for (var f in files) {
      if (f.statSync().type == FileSystemEntityType.file) {
        if (supportAudioFormat(extension(f.path))) {
          await parserMusic(f);
        }
      } else if (f.statSync().type == FileSystemEntityType.directory) {
        final subDir = Directory(f.path);
        await scanMusics(subDir);
      }
    }
  }

  Future<void> parserMusic(FileSystemEntity file) async {
    // print("handling file ${file.path}");
    try {
      final TaggyFile taggyFile = await Taggy.readPrimary(file.path);
      var title = taggyFile.tags.first.trackTitle ?? "";
      var artist = taggyFile.tags.first.trackArtist ?? "";
      var album = taggyFile.tags.first.album ?? "";
      var lyrics = taggyFile.tags.first.lyrics ?? "";

      // print('$artist ($album)- $title');
    } catch (e) {
      print(e);
    }
  }

  bool supportAudioFormat(String ext) {
    final formats = [".flac", ".ogg", ".mp3"];
    final supported = formats.any((e) => e == ext);
    return supported;
  }
}
