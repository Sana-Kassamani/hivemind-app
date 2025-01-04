import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:hivemind_app/utils/colors.dart';

Widget HiveDetailsCard(
    {context, iconColor, circleColor, imagePath, title, content}) {
  return Card(
    color: ColorManager.CARD_BG,
    child: Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 13),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: circleColor,
                child: imageBox(
                  imagePath,
                  iconColor,
                ),
              ),
              Text(
                content,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    ),
  );
}

Widget diseasesCard({context, diseasesList}) {
  String diseases = "\n";
  if (diseasesList.isEmpty) {
    diseases = "\nNo diseases";
  } else {
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < diseasesList.length; i++) {
      if (i == diseasesList.length - 1) {
        buffer.write(diseasesList[i]);
      } else {
        buffer.writeln(diseasesList[i]);
      }
    }
    diseases = buffer.toString();
  }
  return HiveDetailsCard(
    context: context,
    iconColor: ColorManager.DISEASES_COLOR,
    circleColor: ColorManager.DISEASES_BG,
    imagePath: "assets/icons/diseases_icon.png",
    title: diseases,
    content: "Diseases",
  );
}

Widget DateCard(context, title, date) {
  return Card(
    color: ColorManager.CARD_BG,
    child: Container(
      width: (MediaQuery.of(context).size.width - 70) / 2,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 13),
      child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              date,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ]),
    ),
  );
}
