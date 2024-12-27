import 'package:flutter/material.dart';

class ClearTextBtn extends StatelessWidget {
  const ClearTextBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 30, bottom: 10),
        child: TextButton(
          style: ButtonStyle(
              padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
              minimumSize: WidgetStatePropertyAll(Size.zero),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          onPressed: () {},
          child: Text(
            "Clear Completed",
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
