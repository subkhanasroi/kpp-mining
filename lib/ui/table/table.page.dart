import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kppmining_calculator/component/appbar.component.dart';
import 'package:kppmining_calculator/controller/table/table.controller.dart';

class TablePage extends StatelessWidget {
  const TablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: TableController(),
        builder: (controller) {
          return Scaffold(
            appBar: const AppBarCustom(),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
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
                          final data = controller.dataTanggal.value;
                          return Column(
                            children: [
                              _buildDateTime('PIT', data.pit),
                              _buildDateTime('HARI/Tanggal', data.date),
                              _buildDateTime('Shift', data.shift),
                              _buildDateTime('Type Bit', data.typeBit),
                            ],
                          );
                        }),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: ElevatedButton(
                                  onPressed: controller.gotoEditData,
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
                                  onPressed: controller.getToInspectData,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey.shade300,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    'Lihat Data',
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        const Text(
                          'Pattern:',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                        Obx(() => Text(
                              ' ${controller.patternText.value}',
                              style: const TextStyle(fontSize: 14),
                            )),
                        const Spacer(),
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {
                              final patternOptions = [
                                "6x7",
                                "7.5x8.5",
                                "7x8",
                                "8x8",
                                "8x9",
                                "9x10",
                              ];
                              String selectedPattern =
                                  controller.patternText.value;

                              showDialog(
                                context: context,
                                builder: (_) {
                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return AlertDialog(
                                        title: const Text('Edit Table Pattern'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            DropdownButtonFormField<String>(
                                              value: selectedPattern,
                                              decoration: const InputDecoration(
                                                  labelText: 'Pattern'),
                                              isExpanded: true,
                                              items:
                                                  patternOptions.map((pattern) {
                                                return DropdownMenuItem(
                                                  value: pattern,
                                                  child: Text(pattern),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                if (value != null) {
                                                  setState(() {
                                                    selectedPattern = value;
                                                    controller
                                                        .setPattern(value);
                                                  });
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              child: Text(
                                                'Select Pattern',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Edit Pattern',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        const Text(
                          'Table:',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                        Obx(() => Text(
                              ' ${controller.rowCount.toString()}x${controller.colCount.toString()}',
                              style: const TextStyle(fontSize: 14),
                            )),
                        const Spacer(),
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {
                              final rowCtrl = TextEditingController(
                                  text: controller.rowCount.value.toString());
                              final colCtrl = TextEditingController(
                                  text: controller.colCount.value.toString());
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return AlertDialog(
                                        title: const Text('Edit Table Pattern'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: TextField(
                                                    controller: rowCtrl,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'Rows (max 20)'),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: TextField(
                                                    controller: colCtrl,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'Columns (max 20)'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            onPressed: () {
                                              final rows =
                                                  int.tryParse(rowCtrl.text) ??
                                                      8;
                                              final cols =
                                                  int.tryParse(colCtrl.text) ??
                                                      8;
                                              if (rows <= 20 && cols <= 20) {
                                                controller.setDimensions(
                                                    rows: rows, cols: cols);
                                                Get.back();
                                              } else {
                                                Get.snackbar('Maksimal 20',
                                                    'Jumlah baris dan kolom tidak boleh lebih dari 20');
                                              }
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              child: Text(
                                                'Generate Grid',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Edit Table',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
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
                      child: _buildBrickTabel(controller)),
                  const SizedBox(height: 20),
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
                      child: _buildSummaryTable(controller)),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: controller.exportToPdf,
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
          );
        });
  }

  _buildDateTime(String? label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 120,
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

  Widget _buildBrickTabel(TableController controller) {
    return Obx(() {
      final rowCount = controller.rowCount.value;
      final colCount = controller.colCount.value;
      String getRowLabel(int index) => String.fromCharCode(65 + index);
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: Column(
              children: List.generate((rowCount) + 1, (row) {
                if (row == 0) {
                  return Row(
                    children: List.generate((colCount) + 1, (col) {
                      if (col == colCount) {
                        return const SizedBox(width: 50);
                      }
                      return Container(
                        width: 50,
                        height: 40,
                        alignment: Alignment.center,
                        child: Text('${col + 1}'),
                      );
                    }),
                  );
                }

                return Row(
                  children: [
                    if (row % 2 == 0) const SizedBox(width: 25),
                    ...List.generate(colCount, (col) {
                      return Obx(() {
                        final cell = controller.cellValues[row - 1][col];
                        final value = cell['depth'];
                        final isWet = cell['isWet'] ?? false;
                        return GestureDetector(
                          onTap: () => controller.openDialog(row, col),
                          child: Container(
                            width: 50,
                            height: 40,
                            decoration: BoxDecoration(
                              color:
                                  isWet ? Colors.grey.shade300 : Colors.white,
                              border: Border.all(color: Colors.grey),
                            ),
                            alignment: Alignment.center,
                            child: Text(value),
                          ),
                        );
                      });
                    }),
                    Container(
                      width: 50,
                      height: 40,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(getRowLabel(row - 1)),
                    ),
                  ],
                );
              }),
            ),
          ));
    });
  }

  Widget _buildSummaryTable(TableController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Data Perhitungan Tabel',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Table(
          border: TableBorder.all(color: Colors.grey),
          columnWidths: const {
            0: FlexColumnWidth(),
            1: FlexColumnWidth(),
            2: FlexColumnWidth(),
            3: FlexColumnWidth(),
          },
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Color(0xFFEFEFEF)),
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Jumlah Lubang digunakan',
                      textAlign: TextAlign.center),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Total Jumlah Kedalaman',
                      textAlign: TextAlign.center),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child:
                      Text('Kedalaman rata-rata', textAlign: TextAlign.center),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Volume', textAlign: TextAlign.center),
                ),
              ],
            ),
            TableRow(
              children: [
                Obx(() => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        controller.holeCount.value == 0
                            ? '-'
                            : '${controller.holeCount.value}',
                        textAlign: TextAlign.center,
                      ),
                    )),
                Obx(() => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        controller.holeCount.value == 0
                            ? '-'
                            : controller.totalDepth.value.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                      ),
                    )),
                Obx(() => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        controller.holeCount.value == 0
                            ? '-'
                            : controller.avgDepth.value.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                      ),
                    )),
                Obx(() => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        controller.holeCount.value == 0
                            ? '-'
                            : controller.volume.value.toStringAsFixed(2),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
