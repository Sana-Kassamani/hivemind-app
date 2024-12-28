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
                .bodyMedium
                ?.copyWith(overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    ),
  );
}

Widget DiseasesCard({context}) {
  return HiveDetailsCard(
      context: context,
      iconColor: ColorManager.DISEASES_COLOR,
      circleColor: ColorManager.DISEASES_BG,
      imagePath: "assets/icons/diseases_icon.png",
      title: "Varroa mites",
      content: "Diseases");
}
