import 'package:flutter_playground/features/documentscanner/domain/repositories/document_repository.dart';

class ToggleDocumentFavoriteUseCase {
  final DocumentRepository repository;

  ToggleDocumentFavoriteUseCase(this.repository);

  Future<void> call(String id) async {
    await repository.toggleFavorite(id);
  }
}