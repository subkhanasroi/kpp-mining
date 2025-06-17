import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kppmining_calculator/component/depth_dialog.dart';
import 'package:kppmining_calculator/model/inspect_data.model.dart';
import 'package:kppmining_calculator/ui/table/inspect_data_page.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class TableController extends GetxController {
  final rowCount = 20.obs;
  final colCount = 20.obs;
  final patternText = '8x8'.obs;
  final totalDepth = 0.0.obs;
  final avgDepth = 0.0.obs;
  final holeCount = 0.obs;
  final volume = 0.0.obs;

  late RxList<RxList<String>> cellValues;

  @override
  void onInit() {
    super.onInit();
    initTable(rowCount.value, colCount.value);
  }

  void initTable(int rows, int cols) {
    cellValues = List.generate(
      rows,
      (_) => List.generate(cols, (_) => '-').obs,
    ).obs;
  }

  String getRowLabel(int index) {
    return String.fromCharCode(65 + index);
  }

  double get patternArea {
    final parts = patternText.value.split('x');
    if (parts.length != 2) return 1.0;
    final width = double.tryParse(parts[0]) ?? 1.0;
    final height = double.tryParse(parts[1]) ?? 1.0;
    return width * height;
  }

  void setDimensions({required int rows, required int cols}) {
    if (rows > 20 || cols > 20) return;
    rowCount.value = rows;
    colCount.value = cols;
    patternText.value = '${rows}x$cols';
    initTable(rows, cols);
  }

  Future<void> openDialog(int row, int col) async {
    final result = await Get.dialog(
      DepthDialog(row: row - 1, col: col),
    );

    if (result != null) {
      cellValues[row - 1][col] = result;
      calculateSummary();
    }
  }

  void getToInspectData() {
    final emptyModel = InspectionFormModel(
      pit: '',
      date: '',
      shift: '',
      typeBit: '',
      diameterHole: null,
      burden: null,
      spacing: null,
      totalHole: null,
      averageDepth: null,
      cnUnit: '',
      totalHoleStatus: null,
      wet: false,
      dry: false,
      collapse: false,
      note: '',
    );

    Get.to(
      () => InspectionForPage(
        data: emptyModel,
      ),
    );
  }

  void calculateSummary() {
    int count = 0;
    double total = 0.0;

    for (var row in cellValues) {
      for (var val in row) {
        if (val != '-') {
          final parsed = double.tryParse(val);
          if (parsed != null) {
            total += parsed;
            count++;
          }
        }
      }
    }

    totalDepth.value = total;
    holeCount.value = count;
    avgDepth.value = count > 0 ? total / count : 0;
    volume.value = count > 0 ? patternArea * avgDepth.value * count : 0;
  }

  void showLoading() {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
  }

  void hideLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  Future<void> exportToPdf() async {
    final pdf = pw.Document();
    final rows = rowCount.value;
    final cols = colCount.value;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        build: (context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(12),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(
                  child: pw.Text(
                    'PEMERIKSAAN KONDISI DAN KEDALAMAN LUBANG TEMBAK',
                    style: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                pw.SizedBox(height: 10),

                // KOTAK BESAR GABUNGAN
                pw.Table(
                  border: pw.TableBorder.all(width: 0.8),
                  columnWidths: const {
                    0: pw.FlexColumnWidth(3),
                    1: pw.FlexColumnWidth(2),
                  },
                  children: [
                    pw.TableRow(
                      children: [
                        buildBrickTable(rows, cols),
                        buildFormulirPanel(
                          totalHole: '${holeCount.value}',
                          avgDepth: avgDepth.value.toStringAsFixed(2),
                          volume: volume.value.toStringAsFixed(2),
                          cnUnit: 'DR-0024',
                          dry: '24',
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      format: PdfPageFormat.a4.landscape,
      onLayout: (format) async => pdf.save(),
    );
  }

  pw.Widget buildBrickTable(int rows, int cols) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(4),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Header angka
          pw.Row(
            children: [
              pw.SizedBox(width: 20),
              ...List.generate(cols, (col) {
                return pw.Container(
                  width: 20,
                  height: 14,
                  alignment: pw.Alignment.center,
                  child: pw.Text('${col + 1}',
                      style: const pw.TextStyle(fontSize: 6)),
                );
              }),
              pw.SizedBox(width: 20),
            ],
          ),
          pw.SizedBox(height: 4),

          // Isi grid
          ...List.generate(rows, (row) {
            return pw.Row(
              children: [
                if (row % 2 == 0) pw.SizedBox(width: 10),
                ...List.generate(cols, (col) {
                  final val = cellValues[row][col];
                  return pw.Container(
                    width: 20,
                    height: 20,
                    alignment: pw.Alignment.center,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(width: 0.3),
                    ),
                    child:
                        pw.Text(val, style: const pw.TextStyle(fontSize: 6.5)),
                  );
                }),
                pw.SizedBox(
                  width: 16,
                  height: 20,
                  child: pw.Align(
                    alignment: pw.Alignment.centerRight,
                    child: pw.Text(
                      String.fromCharCode(65 + row),
                      style: const pw.TextStyle(fontSize: 6),
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  pw.Widget buildFormulirPanel({
    required String totalHole,
    required String avgDepth,
    required String volume,
    String cnUnit = '',
    String dry = '',
  }) {
    const style = pw.TextStyle(fontSize: 7);
    return pw.Container(
      padding: const pw.EdgeInsets.all(4),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          _formRow('CN UNIT', cnUnit),
          _formRow('Total Hole', totalHole),
          _formRow('Average Depth (m)', avgDepth),
          _formRow('Volume', volume),
          _formRow('Dry', dry),
          pw.SizedBox(height: 10),
          pw.Text('CATATAN:', style: style),
          pw.Container(height: 40, color: PdfColors.grey100),
          pw.SizedBox(height: 12),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                children: [
                  pw.Text('Dibuat oleh', style: style),
                  pw.SizedBox(height: 20),
                  pw.Container(width: 80, child: pw.Divider(thickness: 0.4)),
                ],
              ),
              pw.Column(
                children: [
                  pw.Text('Disetujui oleh', style: style),
                  pw.SizedBox(height: 20),
                  pw.Container(width: 80, child: pw.Divider(thickness: 0.4)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _formRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 2),
      child: pw.Text('$label: $value', style: const pw.TextStyle(fontSize: 7)),
    );
  }
}
