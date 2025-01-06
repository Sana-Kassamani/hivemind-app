import 'package:flutter/material.dart';

Widget ClearTextBtn(context, text, onPress) => Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(right: 30, bottom: 10),
        child: TextButton(
          style: ButtonStyle(
              padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
              minimumSize: WidgetStatePropertyAll(Size.zero),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          onPressed: onPress,
          child: Text(
            text,
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
