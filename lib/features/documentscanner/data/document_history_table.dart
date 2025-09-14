import 'package:drift/drift.dart';

class DocumentHistoryTable extends Table {
  TextColumn get id => text().withLength(min: 1, max: 36)();
  TextColumn get pdfPath => text().nullable()();
  TextColumn get imagePaths => text()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}