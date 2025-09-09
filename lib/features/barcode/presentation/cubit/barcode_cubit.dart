import 'dart:async';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_playground/features/barcode/data/entity/barcode_history_entity.dart';
import 'package:flutter_playground/features/barcode/domain/usecases/delete_all_barcodes_use_case.dart';
import 'package:flutter_playground/features/barcode/domain/usecases/get_all_barcodes_use_case.dart';
import 'package:flutter_playground/features/barcode/domain/usecases/scan_barcode_use_case.dart';
import 'package:flutter_playground/features/barcode/domain/usecases/toggle_favorite_use_case.dart';
import 'package:flutter_playground/features/barcode/domain/usecases/update_note_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:ui';

part 'barcode_state.dart';

class BarcodeCubit extends Cubit<BarcodeState> {
  final ScanBarcodeUseCase _scanBarcodeUseCase = GetIt.instance<ScanBarcodeUseCase>();
  final GetAllBarcodesUseCase _getAllBarcodesUseCase = GetIt.instance<GetAllBarcodesUseCase>();
  final ToggleFavoriteUseCase _toggleFavoriteUseCase = GetIt.instance<ToggleFavoriteUseCase>();
  final UpdateNoteUseCase _updateNoteUseCase = GetIt.instance<UpdateNoteUseCase>();
  final DeleteAllBarcodesUseCase _deleteAllBarcodesUseCase = GetIt.instance<DeleteAllBarcodesUseCase>();
  StreamSubscription<List<BarcodeHistoryEntity>>? _subscription;

  BarcodeCubit() : super(const BarcodeState());

  Future<void> init() async {
    emit(state.copyWith(status: BarcodeStatus.loading));
    try {
      final barcodes = await _getAllBarcodesUseCase();
      emit(state.copyWith(
        status: BarcodeStatus.success,
        barcodes: barcodes,
      ));

      _subscription?.cancel();
      _subscription = Stream.periodic(const Duration(seconds: 5))
          .asyncMap((_) => _getAllBarcodesUseCase())
          .listen((barcodes) {
        emit(state.copyWith(barcodes: barcodes));
      });
    } catch (e) {
      emit(state.copyWith(
        status: BarcodeStatus.error,
      ));
    }
  }

  Future<void> scanBarcode(InputImage inputImage, CameraLensDirection cameraLensDirection) async {
    if (state.status == BarcodeStatus.scanning) return;
    emit(state.copyWith(status: BarcodeStatus.scanning));

    try {
      final barcodes = await _scanBarcodeUseCase(inputImage);
      final updatedBarcodes = await _getAllBarcodesUseCase();
      emit(state.copyWith(
        status: BarcodeStatus.success,
        barcodes: updatedBarcodes,
        scannedBarcodes: barcodes,
        imageSize: inputImage.metadata?.size,
        rotation: inputImage.metadata?.rotation,
        cameraLensDirection: cameraLensDirection,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BarcodeStatus.error,
      ));
    }
  }

  Future<void> toggleFavorite(String id) async {
    try {
      await _toggleFavoriteUseCase(id);
      final barcodes = await _getAllBarcodesUseCase();
      emit(state.copyWith(
        status: BarcodeStatus.success,
        barcodes: barcodes,
      ));
    } catch (e) {
      debugPrint('--error toggleFavorite: $e');
      emit(state.copyWith(
        status: BarcodeStatus.error,
        errorMessage: 'Failed to toggle favorite: $e',
      ));
    }
  }

  Future<void> updateNote(String id, String note) async {
    try {
      await _updateNoteUseCase(id, note);
      final barcodes = await _getAllBarcodesUseCase();
      emit(state.copyWith(
        status: BarcodeStatus.success,
        barcodes: barcodes,
      ));
    } catch (e) {
      debugPrint('--error updateNote: $e');
      emit(state.copyWith(
        status: BarcodeStatus.error,
        errorMessage: 'Failed to update note: $e',
      ));
    }
  }

  Future<void> deleteAllBarcodes() async {
    try {
      await _deleteAllBarcodesUseCase();
      emit(state.copyWith(
        status: BarcodeStatus.success,
        barcodes: [],
      ));
    } catch (e) {
      debugPrint('--error deleteAllBarcodes: $e');
      emit(state.copyWith(
        status: BarcodeStatus.error,
        errorMessage: 'Failed to delete barcodes: $e',
      ));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}