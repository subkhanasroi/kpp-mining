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
        child: Column(
          children: [
            Container(
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
                  Obx(() {
                    final data = controller.dateTimeData.value;
                    return Column(
                      children: [
                        _buildDateTime('Tanggal', data.tanggal),
                        _buildDateTime('Jam', data.jam),
                        _buildDateTime('Lokasi', data.lokasi),
                        _buildDateTime('RL', data.rl),
                      ],
                    );
                  }),
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
                            onPressed: controller.resetTanggal,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade300,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Hapus Tanggal',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: controller.addQuestion,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Tambah Item Pemeriksaan',
                              textAlign: TextAlign.center,
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
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: controller.exportChecklistToPdf,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Export PDF',
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
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Container(
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
                  children: [
                    const SizedBox(
                      height: 42,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Checklist Aktivitas Drilling',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade400),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Obx(() => Table(
                                border: TableBorder.symmetric(
                                  inside:
                                      BorderSide(color: Colors.grey.shade300),
                                  outside: BorderSide.none,
                                ),
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                columnWidths: const {
                                  0: FlexColumnWidth(1),
                                  1: FlexColumnWidth(4),
                                  2: FlexColumnWidth(1),
                                  3: FlexColumnWidth(1),
                                },
                                children: [
                                  // Header
                                  const TableRow(
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    children: [
                                      Center(
                                          child: Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Text("No",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)))),
                                      Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Text("Item Pemeriksaan",
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Center(
                                          child: Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Text("Ya",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)))),
                                      Center(
                                          child: Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Text("Tidak",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)))),
                                    ],
                                  ),
                                  // Rows
                                  for (int i = 0;
                                      i < controller.checklistItems.length;
                                      i++)
                                    TableRow(
                                      children: [
                                        Center(
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Text("${i + 1}"))),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                            controller
                                                .checklistItems[i].question,
                                            softWrap: true,
                                          ),
                                        ),
                                        Center(
                                          child: Checkbox(
                                            value: controller.checklistItems[i]
                                                    .isCheckedYes ==
                                                true,
                                            onChanged: (val) => controller
                                                .updateChecklist(i, true),
                                          ),
                                        ),
                                        Center(
                                          child: Checkbox(
                                            value: controller.checklistItems[i]
                                                    .isCheckedYes ==
                                                false,
                                            onChanged: (val) => controller
                                                .updateChecklist(i, false),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildDateTime(String? label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label ?? '',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          const Text(
            ': ',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          Expanded(
            child: Text(
              value ?? '',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
