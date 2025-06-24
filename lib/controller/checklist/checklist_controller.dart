import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kppmining_calculator/component/add_question.component.dart';
import 'package:kppmining_calculator/component/change_date_dialog.component.dart';
import 'package:kppmining_calculator/model/date.model.dart';
import 'package:kppmining_calculator/model/checklist_question.model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

enum ChecklistCategory { sebelum, sesudah }

class ChecklistController extends GetxController {
  late Rx<DateModel> dateTimeData;

  late RxList<ChecklistItemModel> checklistItems;

  @override
  void onInit() {
    super.onInit();
    dateTimeData = DateModel(
      tanggal: '-',
      jam: '-',
      lokasi: '-',
      rl: '-',
    ).obs;

    checklistItems = <ChecklistItemModel>[
      ChecklistItemModel(
          question: 'Apakah kondisi dan kedalam lubang tembak sudah diperiksa?',
          category: ChecklistCategory.sebelum),
      ChecklistItemModel(
          question:
              'Apakah informasi peledakan dan bendera merah sudah dipasang pada jalan / akses menuju tambang?',
          category: ChecklistCategory.sebelum),
      ChecklistItemModel(
          question:
              'Apakah informasi akan adanya peledakan sudah diinformasikan ke semua karyawan minimal 1 jam sebelumnya?',
          category: ChecklistCategory.sebelum),
      ChecklistItemModel(
          question:
              'Apakah lokasi peledakan sudah diberitanda peringatan sehingga orang yang tidak berkepentingan dilarang memasuki lokasi peledakan?',
          category: ChecklistCategory.sebelum),
      ChecklistItemModel(
          question:
              'Apakah lokasi bor sudah diisolasi dengan memasang safety line dan rambu - rambu?',
          category: ChecklistCategory.sebelum),
      ChecklistItemModel(
          question:
              'Apakah titik untuk penandaan lubang yang arus di bor sudah disiapkan?',
          category: ChecklistCategory.sebelum),
      ChecklistItemModel(
          question:
              'Apakah Perlengkapan (Tali segitiga geometri) sudah disiapkan?',
          category: ChecklistCategory.sebelum),
      ChecklistItemModel(
          question:
              'Apakah penandaan sudah berdasarkan geometri yang sesuai dengan W.O. dari Drill & Blast Engineer?',
          category: ChecklistCategory.sebelum),
      ChecklistItemModel(
          question: 'Apakah Operator Drill sudah melakukan P2H dengan benar?',
          category: ChecklistCategory.sebelum),
      ChecklistItemModel(
          question:
              'Apakah operator drill sudah diberikan pengarahan instruksi kerja yang jelas?',
          category: ChecklistCategory.sebelum),
      ChecklistItemModel(
          question:
              'Apakah selama proses pengeboran telah sesuai dengan instruksi kerja?',
          category: ChecklistCategory.sebelum),
      ChecklistItemModel(
          question: 'Apakah ada kelainan dari unit Drill selama pengoperasian?',
          category: ChecklistCategory.sebelum),
      ChecklistItemModel(
          question:
              'Apakah Operator Drill sudah melaporkan produktivitasnya perjam ke OCR?',
          category: ChecklistCategory.sebelum),
      ChecklistItemModel(
          question: 'Apakah lubang bor sudah sesuai dengan drill design?',
          category: ChecklistCategory.sesudah),
      ChecklistItemModel(
          question:
              'Apakah ada lubang yang Collaps (buntu) dan telah diberi penandan?',
          category: ChecklistCategory.sesudah),
    ].obs;
  }

  void editTanggal() async {
    DateModel? result = await Get.dialog(const ChangeDateDialogWidget());
    debugPrint('data saya ${result?.tanggal}');
    if (result != null) {
      setDateTime(result);
    }
    return;
  }

  void setDateTime(DateModel data) {
    dateTimeData.value = data;
  }

  void updateChecklist(int index, bool isYes) {
    checklistItems[index].isCheckedYes = isYes;
    checklistItems.refresh();
  }

  void addQuestion() async {
    final category = await showCategoryDialog();
    if (category == null) return;

    String? newQuestion = await Get.dialog<String>(AddQuestionDialog());

    if (newQuestion != null && newQuestion.isNotEmpty) {
      checklistItems.add(ChecklistItemModel(
        question: newQuestion,
        category: category,
      ));
    }
  }

  void resetTanggal() {
    dateTimeData.value = DateModel(
      tanggal: '-',
      jam: '-',
      lokasi: '-',
      rl: '-',
    );
  }

  Future<ChecklistCategory?> showCategoryDialog() async {
    return await Get.dialog<ChecklistCategory>(
      AlertDialog(
        title: const Text('Pilih Kategori'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Sebelum Drilling'),
              onTap: () => Get.back(result: ChecklistCategory.sebelum),
            ),
            ListTile(
              title: const Text('Setelah Drilling'),
              onTap: () => Get.back(result: ChecklistCategory.sesudah),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> exportChecklistToPdf() async {
    final pdf = pw.Document();
    final customFont =
        pw.Font.ttf(await rootBundle.load('assets/font/DejaVuSans.ttf'));

    final date = dateTimeData.value;
    final image = pw.MemoryImage(
      (await rootBundle.load('assets/png/logo-kpp.png')).buffer.asUint8List(),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(24),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Table(border: pw.TableBorder.all(width: 0.5), columnWidths: {
                0: const pw.FlexColumnWidth(2),
                1: const pw.FlexColumnWidth(3),
                2: const pw.FlexColumnWidth(1),
              }, children: [
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
                  pw.Align(
                    alignment: pw.Alignment.bottomCenter,
                    child: pw.Text(
                      '\nCHECKLIST AKTIVITAS DRILLING',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  buildLokasiDataVerticalTable(
                    tanggal: date.tanggal ?? DateTime.now().toString(),
                    jam: date.jam ?? '',
                    lokasi: date.lokasi ?? '',
                    rl: date.rl ?? '',
                  ),
                ]),
              ]),
              pw.Table(
                border: pw.TableBorder.all(width: 0.5),
                columnWidths: const {
                  0: pw.FlexColumnWidth(0.8),
                  1: pw.FlexColumnWidth(4),
                  2: pw.FlexColumnWidth(1),
                  3: pw.FlexColumnWidth(1),
                  4: pw.FlexColumnWidth(2),
                },
                children: [
                  pw.TableRow(
                    decoration:
                        const pw.BoxDecoration(color: PdfColors.grey300),
                    children: [
                      _tableHeader('No'),
                      _tableHeader('Item Pemeriksaan'),
                      _tableHeader('Ya'),
                      _tableHeader('Tidak'),
                      _tableHeader('Keterangan'),
                    ],
                  ),
                  _pdfCategoryRow('A. Sebelum Drilling'),
                  ..._pdfChecklistItems(ChecklistCategory.sebelum, customFont),
                  _pdfCategoryRow('B. Setelah Drilling'),
                  ..._pdfChecklistItems(ChecklistCategory.sesudah, customFont),
                ],
              ),

              pw.Table(border: pw.TableBorder.all(width: 0.5), columnWidths: {
                0: const pw.FlexColumnWidth(1)
              }, children: [
                pw.TableRow(children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Table(
                      columnWidths: const {
                        0: pw.FlexColumnWidth(1),
                        1: pw.FlexColumnWidth(1),
                        2: pw.FlexColumnWidth(1),
                      },
                      children: [
                        pw.TableRow(
                          children: [
                            _footerTitle('Dibuat oleh'),
                            _footerTitle('Diperiksa oleh'),
                            _footerTitle('Diketahui oleh'),
                          ],
                        ),
                        pw.TableRow(
                          children: [
                            pw.SizedBox(height: 40),
                            pw.SizedBox(height: 40),
                            pw.SizedBox(height: 40),
                          ],
                        ),
                        pw.TableRow(
                          children: [
                            _footerPosition('(..............................)'),
                            _footerPosition('(..............................)'),
                            _footerPosition('(..............................)'),
                          ],
                        ),
                        pw.TableRow(
                          children: [
                            _footerPosition('GL. Drill & Blast'),
                            _footerPosition('Section Head Prod.'),
                            _footerPosition('Dept. Head Prod.'),
                          ],
                        ),
                      ],
                    ),
                  )
                ])
              ]),
              pw.SizedBox(height: 24),

              // FOOTER TTD
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }

  List<pw.TableRow> _pdfChecklistItems(
      ChecklistCategory category, pw.Font font) {
    final items = checklistItems.where((e) => e.category == category).toList();
    return List.generate(items.length, (i) {
      final item = items[i];
      return pw.TableRow(children: [
        _cellCenter('${i + 1}'),
        _cellLeft(item.question),
        _checkboxCell(item.isCheckedYes == true, font),
        _checkboxCell(item.isCheckedYes == false, font),
        _cellLeft(''),
      ]);
    });
  }

  pw.TableRow _pdfCategoryRow(String label) => pw.TableRow(
        children: [
          pw.SizedBox(),
          pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text(label,
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
          ),
          pw.SizedBox(),
          pw.SizedBox(),
          pw.SizedBox(),
        ],
      );

  pw.Widget _tableHeader(String text) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(4),
      alignment: pw.Alignment.center,
      child: pw.Text(text,
          style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
    );
  }

  pw.Widget _cellLeft(String text) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(4),
      alignment: pw.Alignment.topLeft,
      child: pw.Text(text, style: const pw.TextStyle(fontSize: 7)),
    );
  }

  pw.Widget _cellCenter(String text) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(4),
      alignment: pw.Alignment.center,
      child: pw.Text(text, style: const pw.TextStyle(fontSize: 7)),
    );
  }

  pw.Widget _checkboxCell(bool checked, pw.Font font) {
    return pw.Container(
      alignment: pw.Alignment.center,
      child: pw.Text(
        checked ? '✔' : '',
        style: pw.TextStyle(fontSize: 9, font: font),
      ),
    );
  }

  pw.Widget _footerTitle(String title) {
    return pw.Container(
      alignment: pw.Alignment.center,
      child: pw.Text(title,
          style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
    );
  }

  pw.Widget _footerPosition(String pos) {
    return pw.Container(
      alignment: pw.Alignment.center,
      child: pw.Text(pos, style: const pw.TextStyle(fontSize: 8)),
    );
  }

  pw.Widget buildLokasiDataVerticalTable({
    String tanggal = '',
    String jam = '',
    String lokasi = '',
    String rl = '',
  }) {
    return pw.Table(
      border: pw.TableBorder.all(width: 0.5),
      columnWidths: const {
        0: pw.FlexColumnWidth(1.5), // Label
        1: pw.FlexColumnWidth(2), // Value
      },
      children: [
        _lokasiRowWithBorder('Tanggal', tanggal),
        _lokasiRowWithBorder('Jam', jam),
        _lokasiRowWithBorder('Lokasi', lokasi),
        _lokasiRowWithBorder('RL', rl),
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
}
