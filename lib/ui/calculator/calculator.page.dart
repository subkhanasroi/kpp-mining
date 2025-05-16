import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kppmining_calculator/controller/calculator/calculator_controller.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CalculatorController());

    return Scaffold(
      appBar: AppBar(title: const Text("Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<CalculatorController>(
          init: CalculatorController(),
          builder: (_) {
            return Column(
              children: [
                Obx(() {
                  return _buildDropdown(
                      title: 'Pattern',
                      hint: 'Select Pattern',
                      items: controller.listPattern,
                      selected: controller.selectedPattern,
                      onChanged: controller.setPattern);
                }),
                // _buildDropdown(title: 'PF', hint: 'Select PF'),
                _buildTextField(
                  title: 'DEPTH (m)',
                  hint: 'Input Depth',
                  controller: controller.inputDepth,
                ),
                IgnorePointer(
                  child: _buildTextField(
                    title: 'PF Hasil',
                    hint: 'Result PF',
                    controller: controller.resultPf,
                  ),
                ),
                IgnorePointer(
                  child: _buildTextField(
                    title: 'T Hasil',
                    hint: 'Result T',
                    controller: controller.resultT,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDropdown({
    String? title,
    String? hint,
    required RxList<String> items,
    required RxnString selected,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? '',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.grey.withOpacity(.2), width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButton(
                  isExpanded: true,
                  underline: const SizedBox(),
                  hint: Text(
                    hint ?? '',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  value: selected.value,
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          ))
                      .toList(),
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    String? title,
    String? hint,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? '',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.grey.withOpacity(.2)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
