import 'package:flutter_playground/features/documentscanner/domain/repositories/document_repository.dart';

class UpdateDocumentNoteUseCase {
  final DocumentRepository repository;

  UpdateDocumentNoteUseCase(this.repository);

  Future<void> call(String id, String note) async {
    await repository.updateNote(id, note);
  }
}