import 'package:flutter_playground/features/documentscanner/domain/repositories/document_repository.dart';

class DeleteAllDocumentsUseCase {
  final DocumentRepository repository;

  DeleteAllDocumentsUseCase(this.repository);

  Future<void> call() async {
    await repository.deleteAllDocuments();
  }
}