import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculatorController extends GetxController {
  late TextEditingController inputDepth;
  late TextEditingController resultPf;
  late TextEditingController resultT;
  late RxList<String> listPattern;
  late RxList<String> listPF;
  var selectedPattern = RxnString();
  var selectedPF = RxnString();
  final FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    inputDepth = TextEditingController(text: 0.toString());
    resultPf = TextEditingController(text: 0.toString());
    resultT = TextEditingController(text: 0.toString());
    listPattern =
        RxList<String>(['6x7', "7.5x8.5", "7x8", "8x8", "8x9", "9x10"]);
    listPF = RxList<String>([]);
    generatePfList();
  }

  @override
  void onReady() {
    super.onReady();
    focusNode.requestFocus();
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

  void hitungHasil() {
    if (selectedPattern.value == null || selectedPF.value == null) return;

    List<String> patternSplit = selectedPattern.value!.split('x');
    double patternWidth = double.tryParse(patternSplit[0]) ?? 0;
    double patternHeight = double.tryParse(patternSplit[1]) ?? 0;

    double depth = double.tryParse(inputDepth.text) ?? 0;
    double pf = double.tryParse(selectedPF.value!) ?? 0;

    double pfHasil = patternWidth * patternHeight * depth * pf;

    double tHasil = depth - (pfHasil / 25);

    resultPf.text = pfHasil.toStringAsFixed(2);
    resultT.text = tHasil.toStringAsFixed(2);
  }
}
