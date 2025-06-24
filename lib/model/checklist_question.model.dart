import 'package:kppmining_calculator/controller/checklist/checklist_controller.dart';

class ChecklistItemModel {
  String question;
  bool? isCheckedYes;
  ChecklistCategory category;

  ChecklistItemModel({
    required this.question,
    this.isCheckedYes,
    required this.category,
  });
}
