import 'package:hive/hive.dart';

// ======================
// MODEL USER
// ======================
class AppUser {
  int id;
  String username;
  String password;
  String role;
  String? avatarPath; // <— tambah ini

  AppUser({
    required this.id,
    required this.username,
    required this.password,
    required this.role,
    this.avatarPath,
  });
}

// ======================
// MANUAL ADAPTER
// ======================
class AppUserAdapter extends TypeAdapter<AppUser> {
  @override
  final int typeId = 1;

  @override
  AppUser read(BinaryReader reader) {
    return AppUser(
      id: reader.readInt(),
      username: reader.readString(),
      password: reader.readString(),
      role: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, AppUser obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.username);
    writer.writeString(obj.password);
    writer.writeString(obj.role);
  }
}
