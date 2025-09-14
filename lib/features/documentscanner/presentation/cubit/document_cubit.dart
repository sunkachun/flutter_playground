import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_playground/features/barcode/domain/usecases/toggle_favorite_use_case.dart';
import 'package:flutter_playground/features/barcode/domain/usecases/update_note_use_case.dart';
import 'package:flutter_playground/features/documentscanner/domain/entities/document_history_entity.dart';
import 'package:flutter_playground/features/documentscanner/domain/usecase/delete_all_documents_use_case.dart';
import 'package:flutter_playground/features/documentscanner/domain/usecase/get_all_documents_use_case.dart';
import 'package:flutter_playground/features/documentscanner/domain/usecase/scan_document_use_case.dart';

import 'package:get_it/get_it.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';

part 'document_state.dart';

class DocumentCubit extends Cubit<DocumentState> {
  final ScanDocumentUseCase _scanDocumentUseCase = GetIt.instance<ScanDocumentUseCase>();
  final GetAllDocumentsUseCase _getAllDocumentsUseCase = GetIt.instance<GetAllDocumentsUseCase>();
  final ToggleFavoriteUseCase _toggleFavoriteUseCase = GetIt.instance<ToggleFavoriteUseCase>();
  final UpdateNoteUseCase _updateNoteUseCase = GetIt.instance<UpdateNoteUseCase>();
  final DeleteAllDocumentsUseCase _deleteAllDocumentsUseCase = GetIt.instance<DeleteAllDocumentsUseCase>();
  StreamSubscription<List<DocumentHistoryEntity>>? _subscription;

  DocumentCubit() : super(const DocumentState());

  Future<void> init() async {
    emit(state.copyWith(status: DocumentStatus.loading));
    try {
      final documents = await _getAllDocumentsUseCase();
      emit(state.copyWith(
        status: DocumentStatus.success,
        documents: documents,
      ));

      _subscription?.cancel();
      _subscription = Stream.periodic(const Duration(seconds: 5))
          .asyncMap((_) => _getAllDocumentsUseCase())
          .listen((documents) {
        emit(state.copyWith(documents: documents));
      });
    } catch (e) {
      emit(state.copyWith(
        status: DocumentStatus.error,
        errorMessage: 'Failed to load documents: $e',
      ));
    }
  }

  Future<void> scanDocument({
    required DocumentFormat format,
    required ScannerMode mode,
    int pageLimit = 1,
    bool allowGallery = true,
  }) async {
    if (state.status == DocumentStatus.scanning) return;
    emit(state.copyWith(status: DocumentStatus.scanning));

    try {
      final result = await _scanDocumentUseCase(
        format: format,
        mode: mode,
        pageLimit: pageLimit,
        allowGallery: allowGallery,
      );
      final updatedDocuments = await _getAllDocumentsUseCase();
      emit(state.copyWith(
        status: DocumentStatus.success,
        documents: updatedDocuments,
        scannedDocument: result,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: DocumentStatus.error,
        errorMessage: 'Failed to scan document: $e',
      ));
    }
  }

  Future<void> toggleFavorite(String id) async {
    try {
      await _toggleFavoriteUseCase(id);
      final documents = await _getAllDocumentsUseCase();
      emit(state.copyWith(
        status: DocumentStatus.success,
        documents: documents,
      ));
    } catch (e) {
      debugPrint('--error toggleFavorite: $e');
      emit(state.copyWith(
        status: DocumentStatus.error,
        errorMessage: 'Failed to toggle favorite: $e',
      ));
    }
  }

  Future<void> updateNote(String id, String note) async {
    try {
      await _updateNoteUseCase(id, note);
      final documents = await _getAllDocumentsUseCase();
      emit(state.copyWith(
        status: DocumentStatus.success,
        documents: documents,
      ));
    } catch (e) {
      debugPrint('--error updateNote: $e');
      emit(state.copyWith(
        status: DocumentStatus.error,
        errorMessage: 'Failed to update note: $e',
      ));
    }
  }

  Future<void> deleteAllDocuments() async {
    try {
      await _deleteAllDocumentsUseCase();
      emit(state.copyWith(
        status: DocumentStatus.success,
        documents: [],
      ));
    } catch (e) {
      debugPrint('--error deleteAllDocuments: $e');
      emit(state.copyWith(
        status: DocumentStatus.error,
        errorMessage: 'Failed to delete documents: $e',
      ));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}