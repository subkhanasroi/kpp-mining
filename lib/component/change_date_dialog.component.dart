import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class ChangeDateDialogWidget extends StatelessWidget {
  const ChangeDateDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final tanggalController = TextEditingController();
    final jamMulaiController = TextEditingController();
    final jamSelesaiController = TextEditingController();
    final lokasiController = TextEditingController();
    final rlController = TextEditingController();
    return AlertDialog(
      title: const Text('Edit Tanggal'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: tanggalController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(.2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  labelText: 'Tanggal',
                  hintText: 'dd/mm/yyyy',
                  suffixIcon: const Icon(Icons.date_range)),
              onTap: () async {
                final date = await showDatePicker(
                  context: Get.context!,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  tanggalController.text =
                      '${date.day}/${date.month}/${date.year}';
                }
              },
              readOnly: true,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: jamMulaiController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              BorderSide(color: Colors.grey.withOpacity(.2)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        labelText: 'Jam Mulai'),
                    onTap: () async {
                      final time = await showTimePicker(
                        context: Get.context!,
                        initialTime: const TimeOfDay(hour: 18, minute: 0),
                      );
                      if (time != null) {
                        jamMulaiController.text = time.format(Get.context!);
                      }
                    },
                    readOnly: true,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: jamSelesaiController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              BorderSide(color: Colors.grey.withOpacity(.2)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        labelText: 'Jam Selesai'),
                    onTap: () async {
                      final time = await showTimePicker(
                        context: Get.context!,
                        initialTime: const TimeOfDay(hour: 7, minute: 0),
                      );
                      if (time != null) {
                        jamSelesaiController.text = time.format(Get.context!);
                      }
                    },
                    readOnly: true,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: lokasiController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(.2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  labelText: 'Lokasi'),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: rlController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(.2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  labelText: 'RL'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            // dataList[0]['value'] = tanggalController.text;
            // dataList[1]['value'] =
            //     '${jamMulaiController.text} - ${jamSelesaiController.text}';
            // dataList[2]['value'] = lokasiController.text;
            // dataList[3]['value'] = rlController.text;
            // Get.back();
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
