import 'package:flutter/material.dart';
import 'package:kppmining_calculator/component/appbar.component.dart';
import 'package:kppmining_calculator/model/inspect_data.model.dart';

class InspectionForPage extends StatelessWidget {
  final InspectionFormModel data;

  const InspectionForPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarCustom(),
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
                    _buildDateTime('Wet', data.wet ? '✓' : '×'),
                    _buildDateTime('Dry', data.dry ? '✓' : '×'),
                    _buildDateTime('Collap', data.collapse ? '✓' : '×'),
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
                    const TextField(
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText: 'Tambahkan catatan...',
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Simpan',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SizedBox(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade300,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Reset',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(data.note, style: const TextStyle(fontSize: 16)),
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
