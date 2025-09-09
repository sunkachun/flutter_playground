import 'package:flutter/material.dart';
import 'package:flutter_playground/features/download/domain/entity/download_task_entity.dart';
import 'package:flutter_playground/features/download/presentation/notifier/download_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/download_state.dart';

class DownloadListScreen extends ConsumerWidget {
  const DownloadListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final tasks = [
      DownloadTaskEntity(
        taskId: 'pdf 1',
        url: 'https://ontheline.trincoll.edu/images/bookdown/sample-local-pdf.pdf',
        filename: 'file1.pdf',
        directory: 'downloads',
        openMethod: OpenMethod.pdf,
      ),
      DownloadTaskEntity(
        taskId: 'pdf 2',
        url: 'https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf',
        filename: 'file2.pdf',
        directory: 'downloads',
        openMethod: OpenMethod.pdf,
      ),
      DownloadTaskEntity(
        taskId: 'book1 html',
        url: 'https://www.gutenberg.org/cache/epub/100/pg100-images.html',
        filename: 'book1.html',
        directory: 'downloads',
        openMethod: OpenMethod.html,
      ),
      DownloadTaskEntity(
        taskId: 'book2 html',
        url: 'https://www.gutenberg.org/cache/epub/11/pg11-images.html',
        filename: 'book2.html',
        directory: 'downloads',
        openMethod: OpenMethod.html,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Download Manager')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return DownloadItem(task: tasks[index]);
        },
      ),
    );
  }
}

class DownloadItem extends ConsumerWidget {
  final DownloadTaskEntity task;
  const DownloadItem({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(downloadProvider(task));
    return ListTile(
      title: Text(task.filename),
      subtitle: state.status == DownloadStatus.downloading
          ? Text('Progress: ${(state.progress * 100).round()}%')
          : Text(state.status.toString().split('.').last),
      trailing: ElevatedButton(
        onPressed: () {
          final notifier = ref.read(downloadProvider(task).notifier);
          switch (state.status) {
            case DownloadStatus.initial:
            case DownloadStatus.failed:
              notifier.startDownload();
              break;
            case DownloadStatus.downloading:
              notifier.pauseDownload();
              break;
            case DownloadStatus.paused:
              notifier.resumeDownload();
              break;
            case DownloadStatus.completed:
              notifier.openFile();
              break;
          }
        },
        child: Text(_getButtonText(state.status)),
      ),
    );
  }

  String _getButtonText(DownloadStatus status) {
    switch (status) {
      case DownloadStatus.initial:
      case DownloadStatus.failed:
        return 'Download';
      case DownloadStatus.downloading:
        return 'Pause';
      case DownloadStatus.paused:
        return 'Resume';
      case DownloadStatus.completed:
        return 'View';
    }
  }
}