import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  const path = r'C:\Users\zengkid\StudioProjects\1.mkv';
  var file = File(path);
  var fileLength = await file.length();

  final range = context.request.headers[HttpHeaders.rangeHeader];
  var statusCode = HttpStatus.ok;
  int contentLength;
  var p = 0;
  String contentRange;
  if (range != null && range.trim().isNotEmpty) {
    statusCode = HttpStatus.partialContent;
    final rangBytes = range.replaceAll('bytes=', '');
    if (rangBytes.endsWith('-')) {
      p = int.parse(rangBytes.substring(0, rangBytes.indexOf('-')));
      contentLength = fileLength - p;
      contentRange = 'bytes $p-${fileLength - 1}/$fileLength';
    } else {
      final temp1 = rangBytes.substring(0, rangBytes.indexOf('-'));
      final temp2 = rangBytes.substring(rangBytes.indexOf('-') + 1);
      p = int.parse(temp1);
      final toLength = int.parse(temp2);
      contentLength = toLength - p + 1;
      contentRange = '${range.replaceFirst('=', ' ')}/$fileLength';
    }
  } else {
    contentLength = fileLength;
    contentRange = 'bytes 0-${fileLength - 1}/$fileLength';
  }
  var headers = <String, String>{
    HttpHeaders.acceptRangesHeader: 'bytes',
    HttpHeaders.contentLengthHeader: '$contentLength',
    HttpHeaders.contentRangeHeader: contentRange,
    HttpHeaders.contentTypeHeader: 'video/mp4'
  };
  return Response.stream(
      statusCode: statusCode, headers: headers, body: File(path).openRead(p), bufferOutput: true);
}
