import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kppmining_calculator/component/appbar.component.dart';
import 'package:kppmining_calculator/controller/checklist/checklist_controller.dart';

class ChecklistPage extends StatelessWidget {
  const ChecklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChecklistController());
    List<TableRow> buildChecklistGroup(
        ChecklistCategory category, String label) {
      final items = controller.isDrillingMode.value
          ? controller.checklistItemsDrilling
          : controller.checklistItemsBlasting
              .where((e) => e.category == category)
              .toList();
      List<TableRow> rows = [];

      // Add label row spanning all columns (no vertical dividers)
      rows.add(TableRow(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255), // warna abu terang
        ),
        children: [
          const SizedBox(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(),
          const SizedBox(),
        ],
      ));

      // Add checklist items
      rows.addAll(List.generate(items.length, (i) {
        final item = items[i];
        return TableRow(children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text('${i + 1}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(item.question),
          ),
          Center(
            child: Checkbox(
              value: item.isCheckedYes == true,
              onChanged: (val) => controller.updateChecklist(
                  (controller.isDrillingMode.value
                          ? controller.checklistItemsDrilling
                          : controller.checklistItemsBlasting)
                      .indexOf(item),
                  true),
            ),
          ),
          Center(
            child: Checkbox(
              value: item.isCheckedYes == false,
              onChanged: (val) => controller.updateChecklist(
                  (controller.isDrillingMode.value
                          ? controller.checklistItemsDrilling
                          : controller.checklistItemsBlasting)
                      .indexOf(item),
                  false),
            ),
          ),
        ]);
      }));

      return rows;
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        final shouldExit = await Get.dialog<bool>(
          AlertDialog(
            title: const Text('Konfirmasi'),
            content:
                const Text('Apakah Anda yakin ingin keluar dari menu ini?'),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false),
                child: const Text(
                  'Batal',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Get.back(result: true),
                child: const Text(
                  'Ya, Keluar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );

        if (shouldExit == true) {
          Get.back();
        }
      },
      child: Scaffold(
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
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: Obx(
                            () => DropdownButton<String>(
                              borderRadius: BorderRadius.circular(8),
                              value: controller.isDrillingMode.value
                                  ? 'Drilling'
                                  : 'Blasting',
                              dropdownColor: Colors.green[300],
                              iconEnabledColor: Colors.white,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              items:
                                  ['Drilling', 'Blasting'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                controller.isDrillingMode.value =
                                    newValue == 'Drilling';
                              },
                            ),
                          ),
                        ),
                      ),
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
                      SizedBox(
                        height: 42,
                        child: Align(
                          alignment: Alignment.center,
                          child: Obx(() {
                            return Text(
                              'Checklist Aktivitas ${controller.isDrillingMode.value ? 'Drilling' : 'Blasting'}',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            );
                          }),
                        ),
                      ),
                      Expanded(
                        child: Obx(() => SingleChildScrollView(
                              child: Table(
                                border: TableBorder.all(
                                    color: Colors.grey.shade300),
                                columnWidths: const {
                                  0: FlexColumnWidth(1),
                                  1: FlexColumnWidth(3),
                                  2: FlexColumnWidth(1),
                                  3: FlexColumnWidth(1),
                                },
                                children: [
                                  const TableRow(children: [
                                    Center(
                                        child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Text('No',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)))),
                                    Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Text('Item Pemeriksaan',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))),
                                    Center(
                                        child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Text('Ya',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)))),
                                    Center(
                                        child: Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Text('Tidak',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)))),
                                  ]),
                                  ...buildChecklistGroup(
                                      ChecklistCategory.sebelum,
                                      'A. Sebelum ${controller.isDrillingMode.value ? "Drilling" : "Blasting"}'),
                                  ...buildChecklistGroup(
                                      ChecklistCategory.sesudah,
                                      'B. Setelah ${controller.isDrillingMode.value ? "Drilling" : "Blasting"}'),
                                ],
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
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
