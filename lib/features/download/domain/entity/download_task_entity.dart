class DownloadTaskEntity {
  final String taskId;
  final String url;
  final String filename;
  final String directory;
  final OpenMethod openMethod;

  DownloadTaskEntity({
    required this.taskId,
    required this.url,
    required this.filename,
    required this.directory,
    required this.openMethod,
  });
}

enum OpenMethod { pdf, html }