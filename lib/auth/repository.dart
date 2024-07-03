import 'package:isar/isar.dart';
import 'package:tiangou/auth/user.dart';

import '../database/datasource.dart';

class UserRepository {
  Future<User> create(User user) async {
    await writeTxn((isar) async {
      final exists =
          await isar.users.where().usernameEqualTo(user.username).count() > 0;
      if (!exists) {
        await isar.users.put(user);
      }
    });
    return user;
  }

  Future<bool> deleteById(int id) async {
    return writeTxn((isar) async {
      final success = await isar.users.delete(id);
      return success;
    });
  }

  Future<User?> findByUsername(String username) async {
    final isar = await openIsar();
    final user = await isar.users.where().usernameEqualTo(username).findFirst();
    return user;
  }
}
