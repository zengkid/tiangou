import 'dart:io';

import 'package:isar/isar.dart';

import '../auth/user.dart';

Future<Isar> openIsar() async {
  var workPath =
      (Platform.environment['HOME'] ?? Platform.environment['USERPROFILE']) ??
          File(Platform.script.toFilePath()).parent.path;
  var isar = Isar.getInstance();
  if (isar == null || !isar.isOpen) {
    isar = await Isar.open(
      [UserSchema],
      directory: workPath,
    );
  }
  return isar;
}

Isar openIsarSync() {
  var workPath =
      (Platform.environment['HOME'] ?? Platform.environment['USERPROFILE']) ??
          File(Platform.script.toFilePath()).parent.path;
  var isar = Isar.getInstance();
  if (isar == null || !isar.isOpen) {
    isar = Isar.openSync(
      [UserSchema],
      directory: workPath,
    );
  }
  return isar;
}

Future<T> writeTxn<T>(Future<T> Function(Isar isar) callback,
    {bool silent = false}) async {
  final isar = await openIsar();
  var t = await isar.writeTxn(() async {
    return callback(isar);
  }, silent: silent);
  return t;
}

T writeTxnSync<T>(T Function(Isar isar) callback, {bool silent = false}) {
  final isar = openIsarSync();
  final t = isar.writeTxnSync(() {
    return callback(isar);
  }, silent: silent);
  return t;
}
