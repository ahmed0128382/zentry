import 'package:drift/drift.dart';

class AppearanceTable extends Table {
  TextColumn get id => text().withLength(min: 1, max: 50)();

  // store as "system", "light", "dark"

  TextColumn get themeMode => text().withDefault(const Constant("system"))();

  // store seed color as int (ARGB)
  IntColumn get seedColor =>
      integer().withDefault(const Constant(0xFF2196F3))();

  // font family name
  TextColumn get fontFamily => text().withDefault(const Constant("Cairo"))();

  // text scale factor
  RealColumn get textScale => real().withDefault(const Constant(1.0))();

  // season: "spring", "summer", "autumn", "winter"
  TextColumn get season => text().withDefault(const Constant("winter"))();

  @override
  Set<Column> get primaryKey => {id};
}
