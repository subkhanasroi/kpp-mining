import 'package:flutter/material.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildDropdown(title: 'Pattern', hint: 'Select Pattern'),
              _buildDropdown(title: 'PF', hint: 'Select PF'),
              _buildTextField(
                title: 'DEPTH (m)',
                hint: 'Input Depth',
              ),
            ],
          )),
    );
  }

  _buildDropdown({String? title, String? hint}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? '',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(
            height: 8,
          ),
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
                  items: const [],
                  onChanged: (value) {},
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildTextField({String? title, String? hint}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? '',
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.grey.withOpacity(.2)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(12.0), // border radius saat fokus
                borderSide: const BorderSide(
                    color: Colors.grey), // tetap abu-abu saat fokus
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
