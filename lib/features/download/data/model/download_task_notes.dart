import 'package:background_downloader/background_downloader.dart';

class DownloadTaskNotes {
  final DownloadTask task;
  final TaskStatus status;
  final double progress;
  final int expectedFileSize;
  final TaskException? exception;

  DownloadTaskNotes({
    required this.task,
    required this.status,
    required this.exception,
    required this.progress,
    required this.expectedFileSize,
  });
}
