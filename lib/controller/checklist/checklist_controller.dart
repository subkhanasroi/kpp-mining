import 'package:get/get.dart';
import 'package:kppmining_calculator/component/change_date_dialog.component.dart';
import 'package:kppmining_calculator/model/checklist_question.model.dart';

class ChecklistController extends GetxController {
  final RxList dataList = <RxMap<String, String>>[
    {'label': 'Tanggal', 'value': '-'}.obs,
    {'label': 'Jam', 'value': '-'}.obs,
    {'label': 'Lokasi', 'value': '-'}.obs,
    {'label': 'RL', 'value': '-'}.obs,
  ].obs;

  var checklistItems = <ChecklistItemModel>[
    ChecklistItemModel(
        question: 'Apakah kondisi dan kedalam lubang tembak sudah diperiksa?'),
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
  ].obs;

  void updateValue(int index, String newValue) {
    if (index < dataList.length) {
      dataList[index]['value'].value = newValue;
    }
  }

  void updateLabel(int index, String newLabel) {
    if (index < dataList.length) {
      dataList[index]['label'].value = newLabel;
    }
  }

  void editTanggal() {
    Get.dialog(const ChangeDateDialogWidget());
  }

  void updateChecklist(int index, bool isYes) {
    checklistItems[index].isCheckedYes = isYes;
    checklistItems.refresh();
  }
}
