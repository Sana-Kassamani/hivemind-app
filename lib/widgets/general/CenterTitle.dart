import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';

class CenterTitle extends StatelessWidget {
  const CenterTitle({super.key, required this.titleText});
  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10.0,
        children: [
          imageBox('assets/icons/bee_icon.png',
              Theme.of(context).colorScheme.secondary),
          Text(
            titleText,
            style: Theme.of(context).textTheme.titleLarge,
          )
        ],
      ),
    );
  }
}
