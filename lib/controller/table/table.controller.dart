import 'package:get/get.dart';
import 'package:kppmining_calculator/model/inspect_data.model.dart';
import 'package:kppmining_calculator/ui/table/inspect_data_page.dart';

class TableController extends GetxController {
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
}
