import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculatorController extends GetxController {
  late TextEditingController inputDepth;
  late TextEditingController resultPf;
  late TextEditingController resultT;
  late RxList<String> listPattern;
  late RxList listPF;
  var selectedPattern = RxnString();
  var selectedPF = RxnString();

  @override
  void onInit() {
    super.onInit();
    inputDepth = TextEditingController(text: 0.toString());
    resultPf = TextEditingController(text: 0.toString());
    resultT = TextEditingController(text: 0.toString());
    listPattern = RxList<String>(['8x7', '8x8', '8x9']);
    listPF = RxList([]);

    generatePfList();
  }

  void setPattern(String? value) {
    selectedPattern.value = value;
  }

  void setPF(String? value) {
    selectedPF.value = value;
  }

  void generatePfList() {
    listPF.value = List.generate(
      12,
      (index) => (0.15 + index * 0.01).toStringAsFixed(2),
    );
  }
}
