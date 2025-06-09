import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: GridBrickTable()));

class GridBrickTable extends StatelessWidget {
  const GridBrickTable({super.key});

  static const int rowCount = 20;
  static const int colCount = 20;

  String getRowLabel(int index) => String.fromCharCode(65 + index); // A - T

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Brick Style Grid")),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(rowCount + 1, (row) {
              // Header (baris pertama)
              if (row == 0) {
                return Row(
                  children: List.generate(colCount + 1, (col) {
                    if (col == colCount)
                      return const SizedBox(width: 50); // sudut kanan atas
                    return Container(
                      width: 50,
                      height: 40,
                      alignment: Alignment.center,
                      child: Text('${col + 1}'),
                    );
                  }),
                );
              }

              // Baris isi data
              return Row(
                children: [
                  // Offset: Tambah SizedBox setengah kolom untuk row genap
                  if (row % 2 == 0) const SizedBox(width: 25),

                  // Isi kolom
                  ...List.generate(colCount, (col) {
                    return Container(
                      width: 50,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      alignment: Alignment.center,
                      child: const Text('-'),
                    );
                  }),

                  // Label huruf kanan
                  Container(
                    width: 50,
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(getRowLabel(row - 1)),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
