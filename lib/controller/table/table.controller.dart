import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kppmining_calculator/component/depth_dialog.dart';
import 'package:kppmining_calculator/model/inspect_data.model.dart';
import 'package:kppmining_calculator/ui/table/inspect_data_form.dart';
import 'package:kppmining_calculator/ui/table/inspect_data_page.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

class TableController extends GetxController {
  final rowCount = 20.obs;
  final colCount = 20.obs;
  final patternText = '8x8'.obs;
  final totalDepth = 0.0.obs;
  final avgDepth = 0.0.obs;
  final holeCount = 0.obs;
  final volume = 0.0.obs;

  late RxList<RxList<String>> cellValues;
  late Rx<InspectionFormModel> dataTanggal;

  @override
  void onInit() {
    super.onInit();
    dataTanggal = InspectionFormModel(
      pit: '',
      date: DateFormat('EEEE,dd/MM/yyyy', 'id').format(DateTime.now()),
      shift: '',
      typeBit: '',
      diameterHole: null,
      burden: null,
      spacing: null,
      totalHole: null,
      averageDepth: null,
      cnUnit: '',
      totalHoleStatus: null,
      wet: null,
      dry: null,
      collapse: null,
      note: '',
    ).obs;
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
    Get.to(
      () => InspectionForPage(
        data: dataTanggal.value,
      ),
    );
  }

  void gotoEditData() async {
    final result = await Get.to(InspectionFormPage(
      initialData: dataTanggal.value,
    ));

    if (result != null && result is InspectionFormModel) {
      dataTanggal.value = result;
    }
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
    debugPrint(
        'pattern ${patternText.value} =  $patternArea ,${avgDepth.value} , $count  = ${patternArea * avgDepth.value * count}');
    volume.value = count > 0 ? patternArea * avgDepth.value * count : 0;
  }

  Future<void> exportToPdf() async {
    final pdf = pw.Document();
    final rows = rowCount.value;
    final cols = colCount.value;
    final image = pw.MemoryImage(
      (await rootBundle.load('assets/png/logo-kpp.png')).buffer.asUint8List(),
    );
    final customFont =
        pw.Font.ttf(await rootBundle.load('assets/font/DejaVuSans.ttf'));

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(8),
        pageFormat: PdfPageFormat.a4.landscape,
        build: (context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(12),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Table(
                    border: pw.TableBorder.all(width: 0.8),
                    columnWidths: const {
                      0: pw.FlexColumnWidth(2),
                      1: pw.FlexColumnWidth(3),
                      2: pw.FlexColumnWidth(2),
                    },
                    children: [
                      pw.TableRow(children: [
                        pw.Container(
                          padding: const pw.EdgeInsets.all(6),
                          child: pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.center,
                            children: [
                              pw.Container(
                                height: 30,
                                width: 30,
                                child: pw.Image(image),
                              ),
                              pw.SizedBox(width: 8),
                              pw.Expanded(
                                child: pw.Text(
                                  'PT. KALIMANTAN PRIMA PERSADA',
                                  style: const pw.TextStyle(fontSize: 8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'PEMERIKSAAN KONDISI DAN KEDALAMAN LUBANG TEMBAK',
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                                fontSize: 12, fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                        buildLokasiDataVerticalTable(
                          ptt: dataTanggal.value.pit,
                          date: dataTanggal.value.date,
                          shift: dataTanggal.value.shift,
                          typeByt: dataTanggal.value.typeBit,
                          rl: "",
                        ),
                      ])
                    ]),

                // KOTAK BESAR GABUNGAN
                pw.Table(
                  border: pw.TableBorder.all(width: 0.8),
                  columnWidths: const {
                    0: pw.FlexColumnWidth(5),
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
                            cnUnit: dataTanggal.value.cnUnit,
                            dry: dataTanggal.value.dry.toString(),
                            wet: dataTanggal.value.wet.toString(),
                            collapse: dataTanggal.value.collapse.toString(),
                            customFont: customFont,
                            data: dataTanggal.value),
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
                  width: 26,
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

          // Isi grid brick
          ...List.generate(rows, (row) {
            return pw.Row(
              children: [
                if (row % 2 == 0) pw.SizedBox(width: 10),
                ...List.generate(cols, (col) {
                  final val = cellValues[row][col];
                  return pw.Container(
                    width: 26,
                    height: 24,
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

  pw.Widget buildFormulirPanel(
      {required String totalHole,
      required String avgDepth,
      required String volume,
      String cnUnit = '',
      String dry = '',
      String wet = '',
      String collapse = '',
      InspectionFormModel? data,
      Font? customFont}) {
    const style = pw.TextStyle(fontSize: 7);

    return pw.Container(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          buildLokasiDataTable(
            blok: '',
            strip: '',
            elev: '',
            rl: '',
          ),

          buildDiameter(
            diameter: 'Hole(mm)',
            burden: '(m)',
            spacing: '(m)',
            totalHole: '(buah)',
            diameterV: data?.diameterHole.toString() ?? '',
            burdenV: data?.burden.toString() ?? '',
            spacingV: data?.spacing.toString() ?? '',
            totalHoleV: data?.totalHole.toString() ?? '',
          ),
          _formRow('CN UNIT', cnUnit),
          _formRow('Total Hole', totalHole),
          _formRow('Wet', wet, font: customFont),
          _formRow('Dry', dry, font: customFont),
          _formRow('Collapse', collapse, font: customFont),
          _formRow('Average Depth (m)', avgDepth),
          _formRow('Volume', volume),

          // CATATAN (di atas tanda tangan)
          pw.Container(
            width: double.infinity,
            padding: const pw.EdgeInsets.all(6),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: 0.4),
            ),
            height: 60,
            alignment: pw.Alignment.topLeft,
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Catatan:', style: style),
                  pw.Text(dataTanggal.value.note, style: style)
                ]),
          ),

          pw.SizedBox(height: 16),

          // TANDA TANGAN
          pw.Padding(
            padding: const pw.EdgeInsets.all(8),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  children: [
                    pw.Text('Dibuat oleh', style: style),
                    pw.SizedBox(height: 60),
                    pw.Container(width: 80, child: pw.Divider(thickness: 0.4)),
                  ],
                ),
                pw.Column(
                  children: [
                    pw.Text('Disetujui oleh', style: style),
                    pw.SizedBox(height: 60),
                    pw.Container(width: 80, child: pw.Divider(thickness: 0.4)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  pw.Widget _formRow(String label, String value, {Font? font}) {
    return pw.Container(
      width: double.infinity,
      height: 20,
      decoration: const pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(width: 0.3)),
      ),
      child: pw.Row(
        children: [
          pw.Expanded(
            flex: 1,
            child: pw.Container(
              padding: const pw.EdgeInsets.symmetric(horizontal: 6),
              alignment: pw.Alignment.centerLeft,
              child: pw.Text(label,
                  style: const pw.TextStyle(
                    fontSize: 7,
                  )),
            ),
          ),

          // Vertical Divider
          pw.Container(
            width: 0.5,
            color: PdfColors.black,
          ),

          pw.Expanded(
            flex: 1,
            child: pw.Container(
              padding: const pw.EdgeInsets.symmetric(horizontal: 6),
              alignment: pw.Alignment.centerLeft,
              child:
                  pw.Text(value, style: pw.TextStyle(fontSize: 7, font: font)),
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget buildLokasiDataTable({
    String blok = '',
    String strip = '',
    String elev = '',
    String rl = '',
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Tabel atas: Diameter | Burden | Spacing
        pw.Table(
          border: pw.TableBorder.all(width: 0.4),
          columnWidths: const {
            0: pw.FlexColumnWidth(1.2),
            1: pw.FlexColumnWidth(1.2),
            2: pw.FlexColumnWidth(1.2),
            3: pw.FlexColumnWidth(1.2),
            4: pw.FlexColumnWidth(1.2),
          },
          children: [
            // Baris label
            pw.TableRow(
              children: [
                _lokasiHeaderCell('BLOK'),
                _lokasiHeaderCell('STRIP'),
                _lokasiHeaderCell('ELV'),
                _lokasiHeaderCell('RL'),
              ],
            ),
            // Baris nilai
            pw.TableRow(
              children: [
                _lokasiValueCell(blok),
                _lokasiValueCell(strip),
                _lokasiValueCell(elev),
                _lokasiValueCell(rl),
              ],
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget buildDiameter({
    String diameter = '',
    String burden = '',
    String spacing = '',
    String totalHole = '',
    String diameterV = '',
    String burdenV = '',
    String spacingV = '',
    String totalHoleV = '',
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
      children: [
        // Tabel atas: Diameter | Burden | Spacing
        pw.Table(
          border: pw.TableBorder.all(width: 0.4),
          columnWidths: const {
            0: pw.FlexColumnWidth(1.2),
            1: pw.FlexColumnWidth(1.2),
            2: pw.FlexColumnWidth(1.2),
            3: pw.FlexColumnWidth(1.2),
          },
          children: [
            // Baris label
            pw.TableRow(
              children: [
                _lokasiHeaderCell('Diameter'),
                _lokasiHeaderCell('Burden'),
                _lokasiHeaderCell('Spacing'),
                _lokasiHeaderCell('Total Hole'),
              ],
            ),
            // Baris nilai
            pw.TableRow(
              children: [
                _lokasiValueCell('$diameterV\n\n$diameter',
                    position: pw.Alignment.bottomCenter),
                _lokasiValueCell('$burdenV\n\n$burden',
                    position: pw.Alignment.bottomCenter),
                _lokasiValueCell('$spacingV\n\n$spacing',
                    position: pw.Alignment.bottomCenter),
                _lokasiValueCell('$totalHoleV\n\n$totalHole',
                    position: pw.Alignment.bottomCenter),
              ],
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget buildLokasiDataVerticalTable({
    String ptt = '',
    String date = '',
    String shift = '',
    String typeByt = '',
    String rl = '',
  }) {
    return pw.Table(
      border: pw.TableBorder.all(width: 0.5),
      columnWidths: const {
        0: pw.FlexColumnWidth(1.5), // Label
        1: pw.FlexColumnWidth(2), // Value
      },
      children: [
        _lokasiRowWithBorder('PTT', ptt),
        _lokasiRowWithBorder('HARI/TANGGAL', date),
        _lokasiRowWithBorder('SHIFT', shift),
        _lokasiRowWithBorder('TYPE BIT', typeByt),
      ],
    );
  }

  pw.TableRow _lokasiRowWithBorder(String label, String value) {
    return pw.TableRow(
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 3, vertical: 1),
          alignment: pw.Alignment.centerLeft,
          child: pw.Text(label, style: const pw.TextStyle(fontSize: 6)),
        ),
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 3, vertical: 1),
          alignment: pw.Alignment.centerLeft,
          child: pw.Text(value, style: const pw.TextStyle(fontSize: 6)),
        ),
      ],
    );
  }

  pw.Widget _lokasiHeaderCell(String text) {
    return pw.Container(
      alignment: pw.Alignment.center,
      padding: const pw.EdgeInsets.all(4),
      child: pw.Text(text,
          style: pw.TextStyle(fontSize: 7, fontWeight: pw.FontWeight.bold)),
    );
  }

  pw.Widget _lokasiValueCell(String text,
      {pw.AlignmentGeometry position = pw.Alignment.center}) {
    return pw.Container(
      height: 32,
      alignment: position,
      padding: const pw.EdgeInsets.all(4),
      child: pw.Text(text,
          style: const pw.TextStyle(fontSize: 7), textAlign: TextAlign.center),
    );
  }
}
