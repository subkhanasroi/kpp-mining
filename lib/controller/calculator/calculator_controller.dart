import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculatorController extends GetxController {
  late TextEditingController inputDepth;
  late TextEditingController resultPf;
  late TextEditingController resultT;
  late RxList listPattern;
  late RxList listPF;

  @override
  void onInit() {
    super.onInit();
    inputDepth = TextEditingController(text: 0.toString());
    resultPf = TextEditingController(text: 0.toString());
    resultT = TextEditingController(text: 0.toString());
    listPattern = RxList(['8x7', '8x8', '8x9']);
    listPF = RxList([]);
    generatePfList();
  }

  void generatePfList() {
    listPF.value = List.generate(
      12,
      (index) => (0.15 + index * 0.01).toStringAsFixed(2),
    );
  }
}
