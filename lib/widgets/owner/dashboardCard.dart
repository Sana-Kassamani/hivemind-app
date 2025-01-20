import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/colors.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({super.key, required this.number, required this.title});

  final number;
  final title;

  @override
  Widget build(BuildContext context) {
    final inputStyle =
        Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18);
    final cardColor = ColorManager.CARD_BG;
    return SizedBox(
      width: 119,
      child: Card(
        color: cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 15,
            children: [
              Text(
                number.toString(),
                style: inputStyle,
              ),
              Text(
                title,
                style: inputStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
