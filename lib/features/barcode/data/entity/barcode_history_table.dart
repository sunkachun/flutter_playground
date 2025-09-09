import 'package:drift/drift.dart';
import 'package:flutter_playground/features/barcode/data/entity/barcode_history_entity.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

@UseRowClass(BarcodeHistoryEntity)
class BarcodeHistoryTable extends Table {
  TextColumn get id => text()();
  TextColumn get rawValue => text()();
  IntColumn get format => intEnum<BarcodeFormat>()();
  DateTimeColumn get scanTime => dateTime().withDefault(currentDateAndTime)();
  TextColumn get note => text().nullable()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  TextColumn get location => text().nullable()();
  TextColumn get imagePath => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class BarcodeFormatConverter extends TypeConverter<BarcodeFormat, int> {
  const BarcodeFormatConverter();

  @override
  BarcodeFormat fromSql(int fromDb) {
    return BarcodeFormat.values.firstWhere(
          (format) => format.index == fromDb,
      orElse: () => BarcodeFormat.unknown,
    );
  }

  @override
  int toSql(BarcodeFormat value) {
    return value.index;
  }
}