// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BarcodeHistoryTableTable extends BarcodeHistoryTable
    with TableInfo<$BarcodeHistoryTableTable, BarcodeHistoryEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BarcodeHistoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rawValueMeta = const VerificationMeta(
    'rawValue',
  );
  @override
  late final GeneratedColumn<String> rawValue = GeneratedColumn<String>(
    'raw_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<BarcodeFormat, int> format =
      GeneratedColumn<int>(
        'format',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<BarcodeFormat>(
        $BarcodeHistoryTableTable.$converterformat,
      );
  static const VerificationMeta _scanTimeMeta = const VerificationMeta(
    'scanTime',
  );
  @override
  late final GeneratedColumn<DateTime> scanTime = GeneratedColumn<DateTime>(
    'scan_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    rawValue,
    format,
    scanTime,
    note,
    isFavorite,
    location,
    imagePath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'barcode_history_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BarcodeHistoryEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('raw_value')) {
      context.handle(
        _rawValueMeta,
        rawValue.isAcceptableOrUnknown(data['raw_value']!, _rawValueMeta),
      );
    } else if (isInserting) {
      context.missing(_rawValueMeta);
    }
    if (data.containsKey('scan_time')) {
      context.handle(
        _scanTimeMeta,
        scanTime.isAcceptableOrUnknown(data['scan_time']!, _scanTimeMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BarcodeHistoryEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BarcodeHistoryEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      rawValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_value'],
      )!,
      format: $BarcodeHistoryTableTable.$converterformat.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}format'],
        )!,
      ),
      scanTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scan_time'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
    );
  }

  @override
  $BarcodeHistoryTableTable createAlias(String alias) {
    return $BarcodeHistoryTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<BarcodeFormat, int, int> $converterformat =
      const EnumIndexConverter<BarcodeFormat>(BarcodeFormat.values);
}

class BarcodeHistoryTableCompanion
    extends UpdateCompanion<BarcodeHistoryEntity> {
  final Value<String> id;
  final Value<String> rawValue;
  final Value<BarcodeFormat> format;
  final Value<DateTime> scanTime;
  final Value<String?> note;
  final Value<bool> isFavorite;
  final Value<String?> location;
  final Value<String?> imagePath;
  final Value<int> rowid;
  const BarcodeHistoryTableCompanion({
    this.id = const Value.absent(),
    this.rawValue = const Value.absent(),
    this.format = const Value.absent(),
    this.scanTime = const Value.absent(),
    this.note = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.location = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BarcodeHistoryTableCompanion.insert({
    required String id,
    required String rawValue,
    required BarcodeFormat format,
    this.scanTime = const Value.absent(),
    this.note = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.location = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       rawValue = Value(rawValue),
       format = Value(format);
  static Insertable<BarcodeHistoryEntity> custom({
    Expression<String>? id,
    Expression<String>? rawValue,
    Expression<int>? format,
    Expression<DateTime>? scanTime,
    Expression<String>? note,
    Expression<bool>? isFavorite,
    Expression<String>? location,
    Expression<String>? imagePath,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rawValue != null) 'raw_value': rawValue,
      if (format != null) 'format': format,
      if (scanTime != null) 'scan_time': scanTime,
      if (note != null) 'note': note,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (location != null) 'location': location,
      if (imagePath != null) 'image_path': imagePath,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BarcodeHistoryTableCompanion copyWith({
    Value<String>? id,
    Value<String>? rawValue,
    Value<BarcodeFormat>? format,
    Value<DateTime>? scanTime,
    Value<String?>? note,
    Value<bool>? isFavorite,
    Value<String?>? location,
    Value<String?>? imagePath,
    Value<int>? rowid,
  }) {
    return BarcodeHistoryTableCompanion(
      id: id ?? this.id,
      rawValue: rawValue ?? this.rawValue,
      format: format ?? this.format,
      scanTime: scanTime ?? this.scanTime,
      note: note ?? this.note,
      isFavorite: isFavorite ?? this.isFavorite,
      location: location ?? this.location,
      imagePath: imagePath ?? this.imagePath,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (rawValue.present) {
      map['raw_value'] = Variable<String>(rawValue.value);
    }
    if (format.present) {
      map['format'] = Variable<int>(
        $BarcodeHistoryTableTable.$converterformat.toSql(format.value),
      );
    }
    if (scanTime.present) {
      map['scan_time'] = Variable<DateTime>(scanTime.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BarcodeHistoryTableCompanion(')
          ..write('id: $id, ')
          ..write('rawValue: $rawValue, ')
          ..write('format: $format, ')
          ..write('scanTime: $scanTime, ')
          ..write('note: $note, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('location: $location, ')
          ..write('imagePath: $imagePath, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BarcodeHistoryTableTable barcodeHistoryTable =
      $BarcodeHistoryTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [barcodeHistoryTable];
}

typedef $$BarcodeHistoryTableTableCreateCompanionBuilder =
    BarcodeHistoryTableCompanion Function({
      required String id,
      required String rawValue,
      required BarcodeFormat format,
      Value<DateTime> scanTime,
      Value<String?> note,
      Value<bool> isFavorite,
      Value<String?> location,
      Value<String?> imagePath,
      Value<int> rowid,
    });
typedef $$BarcodeHistoryTableTableUpdateCompanionBuilder =
    BarcodeHistoryTableCompanion Function({
      Value<String> id,
      Value<String> rawValue,
      Value<BarcodeFormat> format,
      Value<DateTime> scanTime,
      Value<String?> note,
      Value<bool> isFavorite,
      Value<String?> location,
      Value<String?> imagePath,
      Value<int> rowid,
    });

class $$BarcodeHistoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $BarcodeHistoryTableTable> {
  $$BarcodeHistoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawValue => $composableBuilder(
    column: $table.rawValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<BarcodeFormat, BarcodeFormat, int>
  get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get scanTime => $composableBuilder(
    column: $table.scanTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BarcodeHistoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BarcodeHistoryTableTable> {
  $$BarcodeHistoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawValue => $composableBuilder(
    column: $table.rawValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scanTime => $composableBuilder(
    column: $table.scanTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BarcodeHistoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BarcodeHistoryTableTable> {
  $$BarcodeHistoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get rawValue =>
      $composableBuilder(column: $table.rawValue, builder: (column) => column);

  GeneratedColumnWithTypeConverter<BarcodeFormat, int> get format =>
      $composableBuilder(column: $table.format, builder: (column) => column);

  GeneratedColumn<DateTime> get scanTime =>
      $composableBuilder(column: $table.scanTime, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);
}

class $$BarcodeHistoryTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BarcodeHistoryTableTable,
          BarcodeHistoryEntity,
          $$BarcodeHistoryTableTableFilterComposer,
          $$BarcodeHistoryTableTableOrderingComposer,
          $$BarcodeHistoryTableTableAnnotationComposer,
          $$BarcodeHistoryTableTableCreateCompanionBuilder,
          $$BarcodeHistoryTableTableUpdateCompanionBuilder,
          (
            BarcodeHistoryEntity,
            BaseReferences<
              _$AppDatabase,
              $BarcodeHistoryTableTable,
              BarcodeHistoryEntity
            >,
          ),
          BarcodeHistoryEntity,
          PrefetchHooks Function()
        > {
  $$BarcodeHistoryTableTableTableManager(
    _$AppDatabase db,
    $BarcodeHistoryTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BarcodeHistoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BarcodeHistoryTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$BarcodeHistoryTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> rawValue = const Value.absent(),
                Value<BarcodeFormat> format = const Value.absent(),
                Value<DateTime> scanTime = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BarcodeHistoryTableCompanion(
                id: id,
                rawValue: rawValue,
                format: format,
                scanTime: scanTime,
                note: note,
                isFavorite: isFavorite,
                location: location,
                imagePath: imagePath,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String rawValue,
                required BarcodeFormat format,
                Value<DateTime> scanTime = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BarcodeHistoryTableCompanion.insert(
                id: id,
                rawValue: rawValue,
                format: format,
                scanTime: scanTime,
                note: note,
                isFavorite: isFavorite,
                location: location,
                imagePath: imagePath,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BarcodeHistoryTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BarcodeHistoryTableTable,
      BarcodeHistoryEntity,
      $$BarcodeHistoryTableTableFilterComposer,
      $$BarcodeHistoryTableTableOrderingComposer,
      $$BarcodeHistoryTableTableAnnotationComposer,
      $$BarcodeHistoryTableTableCreateCompanionBuilder,
      $$BarcodeHistoryTableTableUpdateCompanionBuilder,
      (
        BarcodeHistoryEntity,
        BaseReferences<
          _$AppDatabase,
          $BarcodeHistoryTableTable,
          BarcodeHistoryEntity
        >,
      ),
      BarcodeHistoryEntity,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BarcodeHistoryTableTableTableManager get barcodeHistoryTable =>
      $$BarcodeHistoryTableTableTableManager(_db, _db.barcodeHistoryTable);
}
