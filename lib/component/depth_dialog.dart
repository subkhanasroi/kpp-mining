import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class DepthDialog extends StatefulWidget {
  final int row;
  final int col;

  const DepthDialog({super.key, required this.row, required this.col});

  @override
  State<DepthDialog> createState() => _DepthDialogState();
}

class _DepthDialogState extends State<DepthDialog> {
  final TextEditingController _depthController = TextEditingController();

  @override
  void dispose() {
    _depthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Lokasi Lubang:"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text("Rows: ${String.fromCharCode(65 + widget.row)}"),
              const Spacer(),
              Text("Columns: ${widget.col + 1}"),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _depthController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Depth (m)",
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            final newValue = _depthController.text;
            Get.back(result: newValue);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "Generate Depth",
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: () => Get.back(result: ''),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "Hapus",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
