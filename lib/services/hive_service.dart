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

    // Register adapters
    Hive
      ..registerAdapter(AppUserAdapter())
      ..registerAdapter(MenuItemAdapter())
      ..registerAdapter(EquipmentItemAdapter())
      ..registerAdapter(StockItemAdapter());

    await Future.wait([
      Hive.openBox<AppUser>(usersBoxName),
      Hive.openBox(authBoxName),
      Hive.openBox<MenuItem>(menuBoxName),
      Hive.openBox<EquipmentItem>(equipmentBoxName),
      Hive.openBox<StockItem>(stockBoxName),
    ]);

    // Seed admin user
    final usersBox = Hive.box<AppUser>(usersBoxName);
    if (usersBox.isEmpty) {
      usersBox.add(
        AppUser(id: 1, username: 'admin', password: 'admin123', role: 'admin'),
      );
    }
  }
}
