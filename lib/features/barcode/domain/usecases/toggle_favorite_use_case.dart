import 'package:flutter_playground/features/barcode/data/repositories/barcode_repository.dart';

class ToggleFavoriteUseCase {
  final BarcodeRepository _repository;

  ToggleFavoriteUseCase(this._repository);

  Future<void> call(String id) async {
    await _repository.toggleFavorite(id);
  }
}