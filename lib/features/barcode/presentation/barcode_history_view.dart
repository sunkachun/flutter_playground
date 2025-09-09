import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_playground/features/barcode/data/entity/barcode_history_entity.dart';

import 'cubit/barcode_cubit.dart';

class BarcodeHistoryView extends StatefulWidget {
  const BarcodeHistoryView({super.key});

  @override
  State<BarcodeHistoryView> createState() => _BarcodeHistoryViewState();
}

class _BarcodeHistoryViewState extends State<BarcodeHistoryView> {
  @override
  void initState() {
    super.initState();
    context.read<BarcodeCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              context.read<BarcodeCubit>().deleteAllBarcodes();
            },
          ),
        ],
      ),
      body: BlocConsumer<BarcodeCubit, BarcodeState>(
        listener: (context, state) {
          if (state.status == BarcodeStatus.error && state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        builder: (context, state) {
          if (state.status == BarcodeStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == BarcodeStatus.success) {
            final barcodes = state.barcodes;
            if (barcodes.isEmpty) {
              return const Center(child: Text('No barcodes scanned yet.'));
            }
            return ListView.builder(
              itemCount: barcodes.length,
              itemBuilder: (context, index) {
                final barcode = barcodes[index];
                return ListTile(
                  title: Text(barcode.rawValue),
                  subtitle: Text(
                    'Format: ${barcode.format.name} | Scanned: ${barcode.scanTime.toString()}',
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      barcode.isFavorite ? Icons.star : Icons.star_border,
                      color: barcode.isFavorite ? Colors.yellow : null,
                    ),
                    onPressed: () {
                      context.read<BarcodeCubit>().toggleFavorite(barcode.id);
                    },
                  ),
                  onTap: () {
                    _showEditNoteDialog(context, barcode);
                  },
                );
              },
            );
          }
          return const Center(child: Text('Something went wrong.'));
        },
      ),
    );
  }

  Future<void> _showEditNoteDialog(BuildContext context, BarcodeHistoryEntity barcode) async {
    final controller = TextEditingController(text: barcode.note);
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Note'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Enter note'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<BarcodeCubit>().updateNote(barcode.id, controller.text);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}