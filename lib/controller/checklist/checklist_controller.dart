import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kppmining_calculator/component/add_question.component.dart';
import 'package:kppmining_calculator/component/change_date_dialog.component.dart';
import 'package:kppmining_calculator/model/date.model.dart';
import 'package:kppmining_calculator/model/checklist_question.model.dart';

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
          question:
              'Apakah kondisi dan kedalam lubang tembak sudah diperiksa?'),
      ChecklistItemModel(
          question:
              'Apakah informasi peledakan dan bendera merah sudah dipasang pada jalan / akses menuju tambang?'),
      ChecklistItemModel(
          question:
              'Apakah informasi akan adanya peledakan sudah diinformasikan ke semua karyawan minimal 1 jam sebelumnya?'),
      ChecklistItemModel(
          question:
              'Apakah lokasi peledakan sudah diberitanda peringatan sehingga orang yang tidak berkepentingan dilarang memasuki lokasi peledakan?'),
      ChecklistItemModel(
          question:
              'Apakah lokasi bor sudah diisolasi dengan memasang safety line dan rambu - rambu?'),
      ChecklistItemModel(
          question:
              'Apakah titik untuk penandaan lubang yang arus di bor sudah disiapkan?'),
      ChecklistItemModel(
          question:
              'Apakah Perlengkapan (Tali segitiga geometri) sudah disiapkan?'),
      ChecklistItemModel(
          question:
              'Apakah penandaan sudah berdasarkan geometri yang sesuai dengan W.O. dari Drill & Blast Engineer?'),
      ChecklistItemModel(
          question: 'Apakah Operator Drill sudah melakukan P2H dengan benar?'),
      ChecklistItemModel(
          question:
              'Apakah operator drill sudah diberikan pengarahan instruksi kerja yang jelas?'),
      ChecklistItemModel(
          question:
              'Apakah selama proses pengeboran telah sesuai dengan instruksi kerja?'),
      ChecklistItemModel(
          question:
              'Apakah ada kelainan dari unit Drill selama pengoperasian?'),
      ChecklistItemModel(
          question:
              'Apakah Operator Drill sudah melaporkan produktivitasnya perjam ke OCR?'),
      ChecklistItemModel(
          question: 'Apakah lubang bor sudah sesuai dengan drill design?'),
      ChecklistItemModel(
          question:
              'Apakah ada lubang yang Collaps (buntu) dan telah diberi penandan?'),
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
    String? newQuestion = await Get.dialog<String>(AddQuestionDialog());

    if (newQuestion != null && newQuestion.isNotEmpty) {
      checklistItems.add(ChecklistItemModel(question: newQuestion));
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
}
