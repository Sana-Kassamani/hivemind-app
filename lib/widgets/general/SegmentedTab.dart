import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/colors.dart';

class SegmentedTab extends StatelessWidget {
  const SegmentedTab(
      {super.key,
      required this.selectedControl,
      required this.onValueChanged,
      required this.tabs});
  final List<String> tabs;
  final int? selectedControl;
  final onValueChanged;
  @override
  Widget build(BuildContext context) {
    final style =
        Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.amber);
    final double width = (tabs.isNotEmpty
        ? (MediaQuery.of(context).size.width * 0.5) / tabs.length
        : 0);
    return Center(
      child: CupertinoSlidingSegmentedControl(
        groupValue: selectedControl,
        padding: EdgeInsets.all(10),
        children: {
          for (int i = 0; i < tabs.length; i++)
            i: buildSegment(style, tabs[i], width),
        },
        backgroundColor: Colors.white,
        thumbColor: ColorManager.ICON_BG,
        onValueChanged: onValueChanged,
        proportionalWidth: true,
      ),
    );
  }
}

Widget buildSegment(TextStyle? style, String text, double width) => Container(
      padding: EdgeInsets.fromLTRB(width * 0.2, 12, width * 0.2, 12),
      child: Text(
        text,
        style: style,
      ),
    );
