import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kppmining_calculator/component/appbar.component.dart';
import 'package:kppmining_calculator/controller/checklist/checklist_controller.dart';

class ChecklistPage extends StatelessWidget {
  const ChecklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChecklistController());

    return Scaffold(
      appBar: const AppBarCustom(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurStyle: BlurStyle.outer,
                        blurRadius: 2)
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tanggal',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: controller.dataList.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 80,
                              child: Text(
                                item['label']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Text(
                              ': ',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            Expanded(
                              child: Text(
                                item['value']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: ElevatedButton(
                            onPressed: controller.editTanggal,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Edit Tanggal',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Hapus Tanggal',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Contoh mengganti semua value
      //     controller.updateValue(0, '17-05-2025');
      //     controller.updateValue(1, '08:30');
      //     controller.updateValue(2, 'Pit A');
      //     controller.updateValue(3, 'RL 1200');
      //   },
      //   backgroundColor: Colors.green,
      //   child: const Icon(Icons.edit, color: Colors.white),
      // ),
    );
  }
}
