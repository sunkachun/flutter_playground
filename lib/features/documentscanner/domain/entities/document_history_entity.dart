import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_playground/core/database/app_database.dart';
import 'package:uuid/uuid.dart';

class DocumentHistoryEntity extends Equatable {
  final String? id;
  final String? pdfPath;
  final List<String>? imagePaths;
  final bool isFavorite;
  final String? note;
  final DateTime createdAt;

  DocumentHistoryEntity({
    String? id,
    this.pdfPath,
    this.imagePaths,
    this.isFavorite = false,
    this.note,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  @override
  List<Object?> get props => [id, pdfPath, imagePaths, isFavorite, note, createdAt];

  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    return {
      'id': id,
      'pdfPath': pdfPath,
      'imagePaths': jsonEncode(imagePaths),
      'isFavorite': isFavorite,
      'note': note,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  DocumentHistoryTableCompanion toCompanion() {
    return DocumentHistoryTableCompanion(
      id: Value(id ?? '0'),
      pdfPath: Value(pdfPath),
      imagePaths: Value(jsonEncode(imagePaths)),
      isFavorite: Value(isFavorite),
      note: Value(note),
      createdAt: Value(createdAt),
    );
  }
}