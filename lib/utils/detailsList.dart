import 'package:hivemind_app/models/hive.model.dart';
import 'package:hivemind_app/models/iotDetail.model.dart';
import 'package:hivemind_app/utils/colors.dart';

List<Map<String, dynamic>> detailsList({hive, detail}) {
  return [
    {
      "title": "Temperature",
      "content": "${detail.temperature}°C",
      "iconColor": ColorManager.TEMP_COLOR,
      "circleColor": ColorManager.TEMP_BG,
      "imagePath": "assets/icons/temperature_icon.png",
    },
    {
      "title": "Humidity",
      "content": "${detail.humidity}%",
      "iconColor": ColorManager.HUMIDITY_COLOR,
      "circleColor": ColorManager.HUMIDITY_BG,
      "imagePath": "assets/icons/humidity_icon.png",
    },
    {
      "title": "Mass",
      "content": "${detail.mass} kg",
      "iconColor": ColorManager.MASS_COLOR,
      "circleColor": ColorManager.MASS_BG,
      "imagePath": "assets/icons/mass_icon.png",
    },
    // {
    //   "title": "Weather",
    //   "content": "Sunny",
    //   "iconColor": ColorManager.WEATHER_COLOR,
    //   "circleColor": ColorManager.WEATHER_BG,
    //   "imagePath": "assets/icons/weather_icon.png",
    // },
    // {
    //   "title": "Harvest Status",
    //   "content": hive.harvestStatus ? "Ready" : "Pending",
    //   "iconColor": ColorManager.HONEY_COLOR,
    //   "circleColor": ColorManager.HONEY_BG,
    //   "imagePath": "assets/icons/honey_icon.png",
    // },
    {
      "title": "Number of Frames",
      "content": hive.numberOfFrames.toString(),
      "iconColor": ColorManager.FRAME_COLOR,
      "circleColor": ColorManager.FRAME_BG,
      "imagePath": "assets/icons/frame_icon.png",
    },
  ];
}

List<Map<String, String>> datesList({hive, detail}) {
  return [
    // {"title": "Last harvested on", "date": hive.lastHarvestDate},
    {"title": "Inspected on", "date": detail.date}
  ];
}
