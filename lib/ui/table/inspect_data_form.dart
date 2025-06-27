import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kppmining_calculator/component/appbar.component.dart';
import 'package:kppmining_calculator/model/inspect_data.model.dart';
import 'package:intl/intl.dart';

class InspectionFormPage extends StatefulWidget {
  const InspectionFormPage({super.key, this.initialData});
  final InspectionFormModel? initialData;

  @override
  State<InspectionFormPage> createState() => _InspectionFormPageState();
}

class _InspectionFormPageState extends State<InspectionFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final pitC = TextEditingController();
  final dateC = TextEditingController(
      text: DateFormat('EEEE,dd/MM/yyyy', 'id').format(DateTime.now()));
  final shiftC = TextEditingController();
  final typeBitC = TextEditingController();
  final diameterHoleC = TextEditingController();
  final burdenC = TextEditingController();
  final spacingC = TextEditingController();
  final totalHoleC = TextEditingController();
  final averageDepthC = TextEditingController();
  final cnUnitC = TextEditingController();
  final noteC = TextEditingController();

  final wet = TextEditingController();
  final dry = TextEditingController();
  final collapse = TextEditingController();

  @override
  void initState() {
    super.initState();
    final d = widget.initialData;

    pitC.text = d?.pit ?? '';
    dateC.text = d?.date ?? DateFormat('dd-MM-yyyy').format(DateTime.now());
    shiftC.text = d?.shift ?? '';
    typeBitC.text = d?.typeBit ?? '';
    diameterHoleC.text = d?.diameterHole?.toString() ?? '';
    burdenC.text = d?.burden?.toString() ?? '';
    spacingC.text = d?.spacing?.toString() ?? '';
    totalHoleC.text = d?.totalHole?.toString() ?? '';
    averageDepthC.text = d?.averageDepth?.toString() ?? '';
    cnUnitC.text = d?.cnUnit ?? '';
    noteC.text = d?.note ?? '';
    wet.text = d?.wet ?? '';
    dry.text = d?.dry ?? '';
    collapse.text = d?.collapse ?? '';
  }

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
    noteC.dispose();
    wet.dispose();
    dry.dispose();
    collapse.dispose();
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
        wet: wet.text,
        dry: dry.text,
        collapse: collapse.text,
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
              borderSide: const BorderSide(color: Colors.green),
              borderRadius: BorderRadius.circular(16)),
        ),
      ),
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
            _buildDatePickerField('Hari/Tanggal', dateC),
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
            _buildField('Wet', wet, keyboardType: TextInputType.number),
            _buildField('Dry', dry, keyboardType: TextInputType.number),
            _buildField('Collapse', collapse,
                keyboardType: TextInputType.number),
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

  Widget _buildDatePickerField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: GestureDetector(
        onTap: () async {
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            locale: const Locale('id'), // Untuk Bahasa Indonesia
          );
          if (pickedDate != null) {
            controller.text =
                DateFormat('EEEE, dd/MM/yyyy', 'id').format(pickedDate);
          }
        },
        child: AbsorbPointer(
          child: TextFormField(
            controller: controller,
            validator: (value) =>
                value == null || value.isEmpty ? 'Wajib diisi' : null,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              labelText: label,
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(16),
              ),
              suffixIcon: const Icon(Icons.calendar_today),
            ),
          ),
        ),
      ),
    );
  }
}
