import 'package:hive/hive.dart';
import '../models/user.dart';
import 'hive_service.dart';

class AuthService {
  final Box<AppUser> _usersBox = Hive.box<AppUser>(HiveService.usersBoxName);
  final Box _authBox = Hive.box(HiveService.authBoxName);

  static const String currentUserKey = 'current_user_id';

  AppUser? get currentUser {
    final id = _authBox.get(currentUserKey);
    if (id == null) return null;

    try {
      return _usersBox.values.firstWhere((u) => u.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<AppUser?> login(String username, String password) async {
    try {
      final user = _usersBox.values.firstWhere(
        (u) => u.username == username && u.password == password,
      );

      _authBox.put(currentUserKey, user.id);
      return user;
    } catch (e) {
      return null; // user tidak ditemukan
    }
  }

  Future<AppUser?> register(
    String username,
    String password, {
    String role = 'user',
  }) async {
    // cek username sudah digunakan belum
    final exists = _usersBox.values.any(
      (u) => u.username.toLowerCase() == username.toLowerCase(),
    );
    if (exists) return null;

    // auto increment id
    final newId =
        (_usersBox.values
            .map((u) => u.id)
            .fold<int>(0, (p, c) => c > p ? c : p)) +
        1;

    final user = AppUser(
      id: newId,
      username: username,
      password: password,
      role: role,
    );

    await _usersBox.put(newId, user);

    // otomatis login setelah register
    _authBox.put(currentUserKey, newId);

    return user;
  }

  Future<void> logout() async {
    await _authBox.delete(currentUserKey);
  }

  bool get isAdmin => currentUser?.role == 'admin';

  Future<List<AppUser>> getAllUsers() async {
    return _usersBox.values.toList();
  }

  Future<void> deleteUser(int id) async {
    final key = _usersBox.keys.firstWhere(
      (k) => _usersBox.get(k)?.id == id,
      orElse: () => null,
    );

    if (key != null) {
      await _usersBox.delete(key);
    }
  }

  Future<AppUser?> getLoggedInUser() async {
    final id = _authBox.get(currentUserKey);
    if (id == null) return null;

    try {
      return _usersBox.values.firstWhere((u) => u.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateUser(
    int id,
    String newUsername,
    String newPassword,
    String newRole,
  ) async {
    final key = _usersBox.keys.firstWhere(
      (k) => _usersBox.get(k)?.id == id,
      orElse: () => null,
    );

    if (key == null) return;

    final user = _usersBox.get(key);
    if (user == null) return;

    user.username = newUsername;
    user.password = newPassword;
    user.role = newRole;

    await _usersBox.put(key, user);
  }
}
