import 'package:hive/hive.dart';

// ======================
// MODEL MENU
// ======================
class MenuItem {
  int id;
  String name;
  String imagePath;
  double price;

  MenuItem({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.price,
  });
}

// ======================
// MANUAL ADAPTER
// ======================
class MenuItemAdapter extends TypeAdapter<MenuItem> {
  @override
  final int typeId = 2;

  @override
  MenuItem read(BinaryReader reader) {
    return MenuItem(
      id: reader.readInt(),
      name: reader.readString(),
      imagePath: reader.readString(),
      price: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, MenuItem obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.imagePath);
    writer.writeDouble(obj.price);
  }
}
