import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';

class SettingsList extends StatefulWidget {
  const SettingsList({super.key});

  @override
  State<SettingsList> createState() => _SettingsListState();
}

class _SettingsListState extends State<SettingsList> {
  bool isDarkMode = false;
  bool isSoundOn = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        children: [
          ListTile(
            leading: Icon(
              Icons.dark_mode_outlined,
              size: 30,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              "Dark Mode",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            trailing: Switch(
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                }),
          ),
        ],
      ),
    );
  }
}
