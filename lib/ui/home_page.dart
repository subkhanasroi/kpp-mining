import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:kppmining_calculator/ui/calculator/calculator.page.dart';
import 'package:kppmining_calculator/ui/checklist/checklist.page.dart';

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
              _buttonHome(
                icon: 'assets/svg/table.svg',
                title: 'Tabel Kedalaman',
              ),
              _buttonHome(
                icon: 'assets/svg/calculator.svg',
                title: 'Calculator PF &T',
                onTap: () {
                  Get.to(const CalculatorPage());
                },
              ),
              _buttonHome(
                icon: 'assets/svg/check-square.svg',
                title: 'Checklist',
                color: Colors.white,
                textColor: Colors.green,
                onTap: () {
                  Get.to(const ChecklistPage());
                },
              ),
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
    Function()? onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Padding(
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (icon != null && icon.isNotEmpty)
                  SvgPicture.asset(
                    icon,
                    width: 40,
                    height: 40,
                  ),
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
        ),
      );
}
