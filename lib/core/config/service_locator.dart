import 'package:flutter_playground/core/database/app_database.dart';
import 'package:flutter_playground/features/barcode/data/repositories/barcode_repository.dart';
import 'package:flutter_playground/features/barcode/domain/usecases/delete_all_barcodes_use_case.dart';
import 'package:flutter_playground/features/barcode/domain/usecases/get_all_barcodes_use_case.dart';
import 'package:flutter_playground/features/barcode/domain/usecases/scan_barcode_use_case.dart';
import 'package:flutter_playground/features/barcode/domain/usecases/toggle_favorite_use_case.dart';
import 'package:flutter_playground/features/barcode/domain/usecases/update_note_use_case.dart';
import 'package:flutter_playground/features/documentscanner/data/document_repository_impl.dart';
import 'package:flutter_playground/features/documentscanner/data/document_scanner_data_source.dart';
import 'package:flutter_playground/features/documentscanner/domain/repositories/document_repository.dart';
import 'package:flutter_playground/features/documentscanner/domain/usecase/delete_all_documents_use_case.dart';
import 'package:flutter_playground/features/documentscanner/domain/usecase/get_all_documents_use_case.dart';
import 'package:flutter_playground/features/documentscanner/domain/usecase/scan_document_use_case.dart';
import 'package:flutter_playground/features/documentscanner/domain/usecase/toggle_favorite_use_case.dart';
import 'package:flutter_playground/features/documentscanner/domain/usecase/update_note_use_case.dart';
import 'package:flutter_playground/features/download/data/download_manager.dart';
import 'package:flutter_playground/features/download/data/download_repository_impl.dart';
import 'package:flutter_playground/features/download/domain/download_repository.dart';
import 'package:flutter_playground/features/download/domain/usecase/pause_download_use_case.dart';
import 'package:flutter_playground/features/download/domain/usecase/remove_download_use_case.dart';
import 'package:flutter_playground/features/download/domain/usecase/resume_download_use_case.dart';
import 'package:flutter_playground/features/download/domain/usecase/start_download_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
final serviceLocator = GetIt.instance;

void setupLocator() async {
  serviceLocator.registerSingleton<AppDatabase>(AppDatabase());

  serviceLocator.registerSingleton<DownloadManager>(DownloadManager());
  serviceLocator.registerSingleton<DownloadRepository>(DownloadRepositoryImpl(serviceLocator.get<DownloadManager>()));
  serviceLocator.registerSingleton<StartDownloadUseCase>(StartDownloadUseCase(serviceLocator.get<DownloadRepository>()));
  serviceLocator.registerSingleton<PauseDownloadUseCase>(PauseDownloadUseCase(serviceLocator.get<DownloadRepository>()));
  serviceLocator.registerSingleton<RemoveDownloadUseCase>(RemoveDownloadUseCase(serviceLocator.get<DownloadRepository>()));
  serviceLocator.registerSingleton<ResumeDownloadUseCase>(ResumeDownloadUseCase(serviceLocator.get<DownloadRepository>()));

  // Barcode
  serviceLocator.registerSingleton<BarcodeRepository>(
    BarcodeRepository(serviceLocator.get<AppDatabase>()),
  );

  serviceLocator.registerSingleton<BarcodeScanner>(
    BarcodeScanner(),
  );

  serviceLocator.registerSingleton<ScanBarcodeUseCase>(
    ScanBarcodeUseCase(serviceLocator.get<BarcodeRepository>(), serviceLocator.get<BarcodeScanner>()),
  );

  serviceLocator.registerSingleton<GetAllBarcodesUseCase>(
    GetAllBarcodesUseCase(serviceLocator.get<BarcodeRepository>()),
  );

  serviceLocator.registerSingleton<ToggleFavoriteUseCase>(
    ToggleFavoriteUseCase(serviceLocator.get<BarcodeRepository>()),
  );

  serviceLocator.registerSingleton<UpdateNoteUseCase>(
    UpdateNoteUseCase(serviceLocator.get<BarcodeRepository>()),
  );

  serviceLocator.registerSingleton<DeleteAllBarcodesUseCase>(
    DeleteAllBarcodesUseCase(serviceLocator.get<BarcodeRepository>()),
  );

  // Document Scanner Feature
  serviceLocator.registerSingleton<DocumentScannerDataSource>(
    DocumentScannerDataSource(),
  );
  serviceLocator.registerSingleton<DocumentRepository>(
    DocumentRepositoryImpl(serviceLocator.get<DocumentScannerDataSource>(), serviceLocator.get<AppDatabase>()),
  );
  serviceLocator.registerSingleton<ScanDocumentUseCase>(
    ScanDocumentUseCase(serviceLocator.get<DocumentRepository>()),
  );
  serviceLocator.registerSingleton<GetAllDocumentsUseCase>(
    GetAllDocumentsUseCase(serviceLocator.get<DocumentRepository>()),
  );
  serviceLocator.registerSingleton<ToggleDocumentFavoriteUseCase>(
    ToggleDocumentFavoriteUseCase(serviceLocator.get<DocumentRepository>()),
  );
  serviceLocator.registerSingleton<UpdateDocumentNoteUseCase>(
    UpdateDocumentNoteUseCase(serviceLocator.get<DocumentRepository>()),
  );
  serviceLocator.registerSingleton<DeleteAllDocumentsUseCase>(
    DeleteAllDocumentsUseCase(serviceLocator.get<DocumentRepository>()),
  );
}