import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buttonHome(icon: 'assets/table.svg', title: 'Tabel Kedalaman'),
              _buttonHome(title: 'Calculator PF &T'),
              _buttonHome(
                  title: 'Checklist',
                  color: Colors.white,
                  textColor: Colors.green),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonHome({
    String? title,
    String? icon,
    Color? color,
    Color? textColor,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: color ?? Colors.green,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.5),
                    offset: const Offset(2, 2),
                    blurRadius: 5)
              ]),
          child: Row(
            children: [
              SvgPicture.asset(icon ?? ''),
              Center(
                child: Text(
                  title ?? '',
                  style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: 32,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
