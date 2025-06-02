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
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            String question = _questionController.text.trim();
            if (question.isNotEmpty) {
              Get.back(result: question);
            }
          },
          child: const Text('Tambah'),
        ),
      ],
    );
  }
}
