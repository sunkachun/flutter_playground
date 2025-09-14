import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_playground/features/documentscanner/domain/entities/document_history_entity.dart';
import 'package:flutter_playground/features/documentscanner/presentation/cubit/document_cubit.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';
import 'package:open_file/open_file.dart';

class DocumentScannerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('文件掃描器')),
      body: BlocBuilder<DocumentCubit, DocumentState>(
        builder: (context, state) {
          if (state.status == DocumentStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == DocumentStatus.scanning) {
            return const Center(child: Text('正在掃描...'));
          } else if (state.status == DocumentStatus.success) {
            return Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<DocumentCubit>().scanDocument(
                      format: DocumentFormat.pdf,
                      mode: ScannerMode.full,
                      pageLimit: 5,
                      allowGallery: true,
                    );
                  },
                  child: const Text('掃描文件'),
                ),
                if (state.scannedDocument != null)
                  Text('掃描結果: ${state.scannedDocument!.images.length} 頁'),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.documents.length,
                    itemBuilder: (context, index) {
                      final doc = state.documents[index];
                      return buildDocumentHistoryItem(
                        context, doc
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state.status == DocumentStatus.error) {
            return Center(child: Text('錯誤: ${state.errorMessage}'));
          }
          return Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<DocumentCubit>().scanDocument(
                  format: DocumentFormat.pdf,
                  mode: ScannerMode.full,
                  pageLimit: 5,
                  allowGallery: true,
                );
              },
              child: const Text('開始掃描'),
            ),
          );
        },
      ),
    );
  }

  Widget buildDocumentHistoryItem(BuildContext context, DocumentHistoryEntity document) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            openFile(path: document.pdfPath ?? '');
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Document ID: ${document.id ?? 'Unknown'}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 8),
                Text(
                  'PDF Path: ${document.pdfPath ?? 'None'}',
                  style: const TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 8),
                Text(
                  'Image Paths: ${document.imagePaths?.join(', ') ?? 'None'}',
                  style: const TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 8),
                Text(
                  'Note: ${document.note ?? 'No note'}',
                  style: const TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 8),
                Text(
                  'Created: ${document.createdAt}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        document.isFavorite ? Icons.star : Icons.star_border,
                        color: document.isFavorite ? Colors.yellow : null,
                      ),
                      onPressed: () {
                        context.read<DocumentCubit>().toggleFavorite(document.id ?? '');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openFile({required String path}) async {
    try {
      if (path == '') return;
      final result = await OpenFile.open(path);
      if (result.type != ResultType.done) {
        debugPrint('Fail');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}