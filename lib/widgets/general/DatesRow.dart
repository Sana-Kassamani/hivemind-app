import 'package:flutter/material.dart';
import 'package:hivemind_app/widgets/general/HiveDetailsCard.dart';

class DatesRow extends StatefulWidget {
  const DatesRow({super.key});

  @override
  State<DatesRow> createState() => _DatesRowState();
}

class _DatesRowState extends State<DatesRow> {
  List<Map<String, String>> dates = [
    {"title": "Last harvested on", "date": "Sep 8, 2024"},
    {"title": "Last inspected on", "date": "Dec 8, 2024"}
  ];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 12,
      children: [
        for (int i = 0; i < dates.length; i++)
          DateCard(context, dates[i]["title"], dates[i]["date"])
      ],
    );
  }
}
