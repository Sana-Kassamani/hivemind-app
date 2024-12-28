import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:hivemind_app/utils/colors.dart';
import 'package:hivemind_app/widgets/general/CircleIcon.dart';
import 'package:hivemind_app/widgets/general/HiveDetailsCard.dart';

class HiveGrid extends StatefulWidget {
  const HiveGrid({super.key});

  @override
  State<HiveGrid> createState() => _HiveGridState();
}

class _HiveGridState extends State<HiveGrid> {
  List<Map<String, dynamic>> details = [
    {
      "title": "Temperature",
      "content": "25.4°C",
      "iconColor": ColorManager.TEMP_COLOR,
      "circleColor": ColorManager.TEMP_BG,
      "imagePath": "assets/icons/temperature_icon.png",
    },
    {
      "title": "Humidity",
      "content": "16%",
      "iconColor": ColorManager.HUMIDITY_COLOR,
      "circleColor": ColorManager.HUMIDITY_BG,
      "imagePath": "assets/icons/humidity_icon.png",
    },
    {
      "title": "Mass",
      "content": "12.4 kg",
      "iconColor": ColorManager.MASS_COLOR,
      "circleColor": ColorManager.MASS_BG,
      "imagePath": "assets/icons/mass_icon.png",
    },
    {
      "title": "Weather",
      "content": "Sunny",
      "iconColor": ColorManager.WEATHER_COLOR,
      "circleColor": ColorManager.WEATHER_BG,
      "imagePath": "assets/icons/weather_icon.png",
    },
    {
      "title": "Harvest Status",
      "content": "Pending",
      "iconColor": ColorManager.HONEY_COLOR,
      "circleColor": ColorManager.HONEY_BG,
      "imagePath": "assets/icons/honey_icon.png",
    },
    {
      "title": "Number of Frames",
      "content": "12",
      "iconColor": ColorManager.FRAME_COLOR,
      "circleColor": ColorManager.FRAME_BG,
      "imagePath": "assets/icons/frame_icon.png",
    },
    {
      "title": "Varroa mites",
      "content": "Diseases",
      "iconColor": ColorManager.DISEASES_COLOR,
      "circleColor": ColorManager.DISEASES_BG,
      "imagePath": "assets/icons/diseases_icon.png",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        itemCount: details.length,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.7,
          // mainAxisExtent: 100,
          childAspectRatio: 1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 24,
        ),
        itemBuilder: (context, index) {
          return HiveDetailsCard(
              context: context,
              iconColor: details[index]["iconColor"],
              circleColor: details[index]["circleColor"],
              imagePath: details[index]["imagePath"],
              title: details[index]["title"],
              content: details[index]["content"]);
        },
      ),
    );
  }
}
