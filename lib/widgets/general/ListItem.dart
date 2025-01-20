import 'package:flutter/material.dart';
import 'package:hivemind_app/models/alert.model.dart';
import 'package:hivemind_app/models/apiary.model.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:hivemind_app/utils/capitalize.dart';
import 'package:hivemind_app/utils/colors.dart';
import 'package:hivemind_app/utils/parseDate.dart';

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
      tileColor: Theme.of(context).cardColor,
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primaryFixed,
        child: imageBox(
          icon,
          Theme.of(context).iconTheme.color,
        ),
      ),
      title: Text(
        data.label,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      subtitle: data is Apiary
          ? Text(
              capitalize(data.beekeeperName),
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

Widget AlertListItem(context, Alert alert) => ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: Theme.of(context).cardColor,
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primaryFixed,
        child: iconBox(
          Icons.notifications_on_outlined,
          Theme.of(context).iconTheme.color,
        ),
      ),
      title: Text(
        alert.title,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      subtitle: Text(
        alert.message,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      isThreeLine: true,
      trailing: Text(
        parseDateTime(dateTime: alert.time),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
