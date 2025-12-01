import 'package:hive/hive.dart';

// ======================
// MODEL PERALATAN / EQUIPMENT
// ======================
class EquipmentItem {
  int id;
  String name;
  String imagePath;

  EquipmentItem({
    required this.id,
    required this.name,
    required this.imagePath,
  });
}

// ======================
// MANUAL ADAPTER
// ======================
class EquipmentItemAdapter extends TypeAdapter<EquipmentItem> {
  @override
  final int typeId = 3;

  @override
  EquipmentItem read(BinaryReader reader) {
    return EquipmentItem(
      id: reader.readInt(),
      name: reader.readString(),
      imagePath: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, EquipmentItem obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.imagePath);
  }
}
