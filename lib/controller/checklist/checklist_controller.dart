import 'package:get/get.dart';
import 'package:kppmining_calculator/component/change_date_dialog.component.dart';

class ChecklistController extends GetxController {
  final RxList dataList = <RxMap<String, String>>[
    {'label': 'Tanggal', 'value': '-'}.obs,
    {'label': 'Jam', 'value': '-'}.obs,
    {'label': 'Lokasi', 'value': '-'}.obs,
    {'label': 'RL', 'value': '-'}.obs,
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
}
