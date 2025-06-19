import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddQuestionDialog extends StatelessWidget {
  AddQuestionDialog({super.key});

  final TextEditingController _questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tambah Pertanyaan'),
      content: TextField(
        controller: _questionController,
        maxLines: 3,
        decoration: const InputDecoration(
          hintText: 'Masukkan pertanyaan baru',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade300,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Batal',
            style: TextStyle(color: Colors.black),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            String question = _questionController.text.trim();
            if (question.isNotEmpty) {
              Get.back(result: question);
            }
          },
          child: const Text('Tambah', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
