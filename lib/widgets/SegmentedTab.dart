import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/colors.dart';

class SegmentedTab extends StatelessWidget {
  const SegmentedTab(
      {super.key, required this.selectedControl, required this.onValueChanged});

  final int? selectedControl;
  final onValueChanged;
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelMedium;
    return Center(
      child: CupertinoSlidingSegmentedControl(
        groupValue: selectedControl,
        padding: EdgeInsets.all(10),
        children: {
          0: buildSegment(style, 'Hives'),
          1: buildSegment(style, 'Tasks'),
        },
        backgroundColor: Colors.white,
        thumbColor: ColorManager.SCAFFOLD_BG,
        onValueChanged: onValueChanged,
      ),
    );
  }
}

Widget buildSegment(TextStyle? style, String text) => Container(
      padding: EdgeInsets.fromLTRB(35, 12, 35, 12),
      child: Text(
        text,
        style: style,
      ),
    );
