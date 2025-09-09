enum DownloadStatus { initial, downloading, paused, completed, failed }

class DownloadState {
  final DownloadStatus status;
  final double progress;
  final String? error;
  final String? taskId;

  DownloadState({
    this.status = DownloadStatus.initial,
    this.progress = 0.0,
    this.error,
    this.taskId,
  });

  DownloadState copyWith({DownloadStatus? status, double? progress, String? error, String? taskId}) {
    return DownloadState(
      status: status ?? this.status,
      progress: progress ?? this.progress,
      error: error ?? this.error,
      taskId: taskId ?? this.taskId,
    );
  }
}