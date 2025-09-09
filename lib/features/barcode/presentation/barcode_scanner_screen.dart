import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_playground/features/barcode/presentation/painter/barcode_detector_painter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import 'cubit/barcode_cubit.dart';
import 'detector_view.dart';

class BarcodeScannerView extends StatefulWidget {
  const BarcodeScannerView({super.key});

  @override
  State<BarcodeScannerView> createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView> {
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  var _cameraLensDirection = CameraLensDirection.back;
  InputImage? _latestImage;
  Timer? _scanTimer;

  @override
  void initState() {
    super.initState();
    // Start a periodic timer to scan every second
    _scanTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_canProcess && !_isBusy && _latestImage != null) {
        _isBusy = true;
        context.read<BarcodeCubit>().scanBarcode(_latestImage!, _cameraLensDirection);
        _isBusy = false;
      }
    });
  }

  @override
  void dispose() {
    _canProcess = false;
    _scanTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BarcodeCubit, BarcodeState>(
      listener: (context, state) {
        if (state.status == BarcodeStatus.error && state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      builder: (context, state) {
        if (state.status == BarcodeStatus.scanning || state.status == BarcodeStatus.success) {
          if (state.imageSize != null && state.rotation != null && state.cameraLensDirection != null) {
            _customPaint = CustomPaint(
              painter: BarcodeDetectorPainter(
                state.scannedBarcodes,
                state.imageSize!,
                state.rotation!,
                state.cameraLensDirection!,
              ),
            );
          } else {
            String text = 'Barcodes found: ${state.scannedBarcodes.length}\n\n';
            for (final barcode in state.scannedBarcodes) {
              text += 'Barcode: ${barcode.rawValue}\n\n';
            }
            _text = text;
            _customPaint = null;
          }
        }
        return DetectorView(
          title: 'Barcode Scanner',
          customPaint: _customPaint,
          text: _text,
          onImage: (inputImage) {
            // Store the latest image for the timer to process
            _latestImage = inputImage;
          },
          initialCameraLensDirection: _cameraLensDirection,
          onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
        );
      },
    );
  }
}