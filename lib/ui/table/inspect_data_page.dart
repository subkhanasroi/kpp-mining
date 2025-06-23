import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:kppmining_calculator/component/appbar.component.dart';
import 'package:kppmining_calculator/controller/table/table.controller.dart';
import 'package:kppmining_calculator/model/inspect_data.model.dart';

class InspectionForPage extends StatelessWidget {
  final InspectionFormModel data;

  const InspectionForPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TableController());

    return Scaffold(
        appBar: const AppBarCustom(),
        floatingActionButton: InkWell(
          onTap: controller.gotoEditData,
          child: Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 31, 183, 36),
                    Color.fromARGB(255, 134, 165, 89)
                  ],
                )),
            height: 64,
            width: 64,
            child: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: _decoration(),
                child: Column(
                  children: [
                    _buildDateTime('PIT', data.pit),
                    _buildDateTime('Hari/Tanggal', data.date),
                    _buildDateTime('Shift', data.shift),
                    _buildDateTime('Type Bit', data.typeBit),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: _decoration(),
                child: Column(
                  children: [
                    _buildDateTime(
                        'Diameter Hole (mm)', data.diameterHole?.toString()),
                    _buildDateTime('Burden (m)', data.burden?.toString()),
                    _buildDateTime('Spacing (m)', data.spacing?.toString()),
                    _buildDateTime(
                        'Total Hole (buah)', data.totalHole?.toString()),
                    _buildDateTime(
                        'Average Depth (m)', data.averageDepth?.toString()),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: _decoration(),
                child: Column(
                  children: [
                    _buildDateTime('C/N Unit', data.cnUnit),
                    _buildDateTime(
                        'Total Hole', data.totalHoleStatus?.toString()),
                    _buildDateTime('Wet', data.wet.toString()),
                    _buildDateTime('Dry', data.dry.toString()),
                    _buildDateTime('Collap', data.collapse.toString()),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: _decoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Catatan:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(data.note,
                        style: const TextStyle(
                          fontSize: 16,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ));
  }

  BoxDecoration _decoration() {
    return BoxDecoration(boxShadow: const [
      BoxShadow(color: Colors.grey, blurStyle: BlurStyle.outer, blurRadius: 2)
    ], borderRadius: BorderRadius.circular(16), color: Colors.white);
  }

  _buildDateTime(String? label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label ?? '',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          const Text(': ', style: TextStyle(fontSize: 16, color: Colors.black)),
          Expanded(
            child: Text(
              value ?? '',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
