import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:hivemind_app/utils/colors.dart';
import 'package:hivemind_app/widgets/general/CircleIcon.dart';

class ListItem extends StatelessWidget {
  const ListItem(
      {super.key,
      required this.data,
      required this.icon,
      required this.onPress});
  final data;
  final icon;
  final onPress;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      leading: CircleAvatar(
        backgroundColor: ColorManager.ICON_BG,
        child: imageBox(
          icon,
          ColorManager.COLOR_PRIMARY,
        ),
      ),
      // ListIcon(
      //   circleColor: ColorManager.ICON_BG,
      //   iconColor: ColorManager.COLOR_PRIMARY,
      //   imagePath: icon,
      // ),
      title: Text(
        data["label"],
        style: Theme.of(context).textTheme.labelMedium,
      ),
      subtitle: data.containsKey("Beekeeper name")
          ? Text(
              data["Beekeeper name"],
              style: Theme.of(context).textTheme.bodyMedium,
            )
          : null,
      trailing: IconButton(
        onPressed: onPress,
        icon: Icon(Icons.chevron_right),
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
