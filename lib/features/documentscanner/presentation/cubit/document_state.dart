part of 'document_cubit.dart';

enum DocumentStatus { initial, loading, scanning, success, error }

class DocumentState extends Equatable {
  final DocumentStatus status;
  final List<DocumentHistoryEntity> documents;
  final DocumentScanningResult? scannedDocument;
  final String? errorMessage;

  const DocumentState({
    this.status = DocumentStatus.initial,
    this.documents = const [],
    this.scannedDocument,
    this.errorMessage,
  });

  DocumentState copyWith({
    DocumentStatus? status,
    List<DocumentHistoryEntity>? documents,
    DocumentScanningResult? scannedDocument,
    String? errorMessage,
  }) {
    return DocumentState(
      status: status ?? this.status,
      documents: documents ?? this.documents,
      scannedDocument: scannedDocument,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, documents, scannedDocument, errorMessage];
}