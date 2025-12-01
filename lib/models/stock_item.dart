import 'package:hive/hive.dart';

// ======================
// MODEL PERSEDIAAN / STOCK
// ======================
class StockItem {
  int id;
  String name;
  String imagePath;
  int quantity;

  StockItem({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.quantity,
  });
}

// ======================
// MANUAL ADAPTER
// ======================
class StockItemAdapter extends TypeAdapter<StockItem> {
  @override
  final int typeId = 4;

  @override
  StockItem read(BinaryReader reader) {
    return StockItem(
      id: reader.readInt(),
      name: reader.readString(),
      imagePath: reader.readString(),
      quantity: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, StockItem obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.imagePath);
    writer.writeInt(obj.quantity);
  }
}
