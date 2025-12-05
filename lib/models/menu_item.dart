import 'package:hive/hive.dart';

/// MODEL MENU
class MenuItem {
  int id;
  String name;
  String? imagePath;
  String description;
  List<String> persediaan;
  List<String> mesin;
  List<String> proses;

  MenuItem({
    required this.id,
    required this.name,
    this.imagePath,
    this.description = '',
    List<String>? persediaan,
    List<String>? mesin,
    List<String>? proses,
  }) : persediaan = persediaan ?? [],
       mesin = mesin ?? [],
       proses = proses ?? [];
}

/// MANUAL ADAPTER HIVE
class MenuItemAdapter extends TypeAdapter<MenuItem> {
  @override
  final int typeId = 2; // pastikan belum dipakai adapter lain

  @override
  MenuItem read(BinaryReader reader) {
    final id = reader.readInt();
    final name = reader.readString();

    final hasImage = reader.readBool();
    final imagePath = hasImage ? reader.readString() : null;

    final description = reader.readString();
    final persediaan = reader.readList().cast<String>();
    final mesin = reader.readList().cast<String>();
    final proses = reader.readList().cast<String>();

    return MenuItem(
      id: id,
      name: name,
      imagePath: imagePath,
      description: description,
      persediaan: persediaan,
      mesin: mesin,
      proses: proses,
    );
  }

  @override
  void write(BinaryWriter writer, MenuItem obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);

    if (obj.imagePath != null) {
      writer.writeBool(true);
      writer.writeString(obj.imagePath!);
    } else {
      writer.writeBool(false);
    }

    writer.writeString(obj.description);
    writer.writeList(obj.persediaan);
    writer.writeList(obj.mesin);
    writer.writeList(obj.proses);
  }
}
