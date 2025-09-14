import 'package:flutter_playground/features/documentscanner/domain/entities/document_history_entity.dart';
import 'package:flutter_playground/features/documentscanner/domain/repositories/document_repository.dart';

class GetAllDocumentsUseCase {
  final DocumentRepository repository;

  GetAllDocumentsUseCase(this.repository);

  Future<List<DocumentHistoryEntity>> call() async {
    return await repository.getAllDocuments();
  }
}