import 'package:flutter/material.dart';

Widget EmptyState({required context}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        SizedBox(
          width: 100,
          child: Image.asset(
            "assets/images/empty_pic.png",
            color: Colors.grey[400],
            fit: BoxFit.contain,
          ),
        ),
        Text(
          "Oops! It's Empty",
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Colors.grey[400]),
        )
      ],
    ),
  );
}
