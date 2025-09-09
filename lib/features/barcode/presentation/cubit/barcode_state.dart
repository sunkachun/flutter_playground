part of 'barcode_cubit.dart';

enum BarcodeStatus { initial, loading, scanning, success, error }

class BarcodeState extends Equatable {
  final BarcodeStatus status;
  final List<BarcodeHistoryEntity> barcodes;
  final List<Barcode> scannedBarcodes;
  final String? errorMessage;
  final Size? imageSize;
  final InputImageRotation? rotation;
  final CameraLensDirection? cameraLensDirection;

  const BarcodeState({
    this.status = BarcodeStatus.initial,
    this.barcodes = const [],
    this.scannedBarcodes = const [],
    this.errorMessage,
    this.imageSize,
    this.rotation,
    this.cameraLensDirection,
  });

  BarcodeState copyWith({
    BarcodeStatus? status,
    List<BarcodeHistoryEntity>? barcodes,
    List<Barcode>? scannedBarcodes,
    String? errorMessage,
    Size? imageSize,
    InputImageRotation? rotation,
    CameraLensDirection? cameraLensDirection,
  }) {
    return BarcodeState(
      status: status ?? this.status,
      barcodes: barcodes ?? this.barcodes,
      scannedBarcodes: scannedBarcodes ?? this.scannedBarcodes,
      errorMessage: errorMessage,
      imageSize: imageSize,
      rotation: rotation,
      cameraLensDirection: cameraLensDirection,
    );
  }

  @override
  List<Object?> get props => [
    status,
    barcodes,
    scannedBarcodes,
    errorMessage,
    imageSize,
    rotation,
    cameraLensDirection,
  ];
}