import 'package:hive_flutter/hive_flutter.dart';
import '../models/user.dart';
import '../models/menu_item.dart';
import '../models/equipment_item.dart';
import '../models/stock_item.dart';

class HiveService {
  static const String usersBoxName = 'users_box';
  static const String authBoxName = 'auth_box';
  static const String menuBoxName = 'menu_box';
  static const String equipmentBoxName = 'equipment_box';
  static const String stockBoxName = 'stock_box';

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive
      ..registerAdapter(AppUserAdapter())
      ..registerAdapter(MenuItemAdapter())
      ..registerAdapter(EquipmentItemAdapter())
      ..registerAdapter(StockItemAdapter());

    await Hive.openBox<AppUser>(usersBoxName);
    await Hive.openBox(authBoxName);
    await Hive.openBox<MenuItem>(menuBoxName);
    await Hive.openBox<EquipmentItem>(equipmentBoxName);
    await Hive.openBox<StockItem>(stockBoxName);

    // SAFE: memastikan box benar-benar open
    final usersBox = Hive.box<AppUser>(usersBoxName);

    if (usersBox.isEmpty) {
      usersBox.add(
        AppUser(
          id: 1,
          username: 'admin',
          password: 'admin123',
          role: 'admin',
          avatarPath: null,
        ),
      );
    }
  }
}
