import 'package:hive/hive.dart';

class AppUser {
  int id;
  String username;
  String password;
  String role;
  String? avatarPath;

  AppUser({
    required this.id,
    required this.username,
    required this.password,
    required this.role,
    this.avatarPath,
  });
}

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
      avatarPath: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, AppUser obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.username);
    writer.writeString(obj.password);
    writer.writeString(obj.role);
    writer.write(obj.avatarPath);
  }
}
