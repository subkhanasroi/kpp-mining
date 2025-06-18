import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kppmining_calculator/component/appbar.component.dart';
import 'package:kppmining_calculator/model/inspect_data.model.dart';
import 'package:intl/intl.dart';

class InspectionFormPage extends StatefulWidget {
  const InspectionFormPage({super.key});

  @override
  State<InspectionFormPage> createState() => _InspectionFormPageState();
}

class _InspectionFormPageState extends State<InspectionFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final pitC = TextEditingController();
  final dateC = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
  final shiftC = TextEditingController();
  final typeBitC = TextEditingController();
  final diameterHoleC = TextEditingController();
  final burdenC = TextEditingController();
  final spacingC = TextEditingController();
  final totalHoleC = TextEditingController();
  final averageDepthC = TextEditingController();
  final cnUnitC = TextEditingController();
  final totalHoleStatusC = TextEditingController();
  final noteC = TextEditingController();

  // Checkbox values
  bool wet = false;
  bool dry = false;
  bool collapse = false;

  @override
  void dispose() {
    // Dispose all controllers
    pitC.dispose();
    dateC.dispose();
    shiftC.dispose();
    typeBitC.dispose();
    diameterHoleC.dispose();
    burdenC.dispose();
    spacingC.dispose();
    totalHoleC.dispose();
    averageDepthC.dispose();
    cnUnitC.dispose();
    totalHoleStatusC.dispose();
    noteC.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final data = InspectionFormModel(
        pit: pitC.text,
        date: dateC.text,
        shift: shiftC.text,
        typeBit: typeBitC.text,
        diameterHole: int.tryParse(diameterHoleC.text),
        burden: int.tryParse(burdenC.text),
        spacing: int.tryParse(spacingC.text),
        totalHole: int.tryParse(totalHoleC.text),
        averageDepth: double.tryParse(averageDepthC.text),
        cnUnit: cnUnitC.text,
        totalHoleStatus: int.tryParse(totalHoleStatusC.text),
        wet: wet,
        dry: dry,
        collapse: collapse,
        note: noteC.text,
      );

      Get.back(result: data);
    }
  }

  Widget _buildField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text,
      bool isRequired = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: isRequired
            ? (value) => value == null || value.isEmpty ? 'Wajib diisi' : null
            : null,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: label,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
              borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }

  Widget _buildCheckbox(String label, bool value, Function(bool?) onChanged) {
    return CheckboxListTile(
      title: Text(label),
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildField('PIT', pitC),
            _buildField('Hari/Tanggal', dateC),
            _buildField('Shift', shiftC),
            _buildField('Type Bit', typeBitC),
            _buildField('Diameter Hole (mm)', diameterHoleC,
                keyboardType: TextInputType.number),
            _buildField('Burden (m)', burdenC,
                keyboardType: TextInputType.number),
            _buildField('Spacing (m)', spacingC,
                keyboardType: TextInputType.number),
            _buildField('Total Hole (buah)', totalHoleC,
                keyboardType: TextInputType.number),
            _buildField('Average Depth (m)', averageDepthC,
                keyboardType: TextInputType.number),
            _buildField('C/N Unit', cnUnitC),
            _buildField('Total Hole Status', totalHoleStatusC,
                keyboardType: TextInputType.number),
            const SizedBox(height: 8),
            _buildCheckbox(
                'Wet', wet, (val) => setState(() => wet = val ?? false)),
            _buildCheckbox(
                'Dry', dry, (val) => setState(() => dry = val ?? false)),
            _buildCheckbox('Collapse', collapse,
                (val) => setState(() => collapse = val ?? false)),
            _buildField('Catatan', noteC, isRequired: true),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _submitForm,
              child: const Text(
                'Simpan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
