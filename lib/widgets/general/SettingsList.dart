import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/auth.provider.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:hivemind_app/utils/colors.dart';
import 'package:hivemind_app/widgets/owner/alert.dialogue.dart';
import 'package:provider/provider.dart';

class SettingsList extends StatefulWidget {
  const SettingsList({super.key});

  @override
  State<SettingsList> createState() => _SettingsListState();
}

class _SettingsListState extends State<SettingsList> {
  Future changeDarkMode(authValue, value) async {
    try {
      await authValue.setDarkMode(value: value);
      print("Dark mode changed");
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Set dark mode failed: ${error.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future changeAlerts(authValue, value, context) async {
    try {
      await authValue.setAlerts(value: value, context: context);
      print("Alerts changed");
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Set alerts failed: ${error.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<Auth>(
          builder: (BuildContext context, Auth authValue, Widget? child) {
        return ListView(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          children: [
            ListTile(
              leading: Icon(
                Icons.dark_mode_outlined,
                size: 30,
                color: Colors.black,
              ),
              title: Text(
                "Dark Mode",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              trailing: Switch(
                  trackOutlineColor: WidgetStateColor.resolveWith(
                    (final Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return Theme.of(context).colorScheme.primary;
                      }

                      return Colors.grey;
                    },
                  ),
                  inactiveThumbColor: Colors.grey[350],
                  inactiveTrackColor: ColorManager.SCAFFOLD_BG,
                  activeColor: Theme.of(context).colorScheme.primary,
                  activeTrackColor: ColorManager.SCAFFOLD_BG,
                  value: authValue.user.getSettings.darkmode,
                  onChanged: (value) async {
                    await changeDarkMode(authValue, value);
                  }),
            ),
            addVerticalSpace(10),
            ListTile(
              leading: Icon(
                Icons.volume_up,
                size: 30,
                color: Colors.black,
              ),
              title: Text(
                "Alerts",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              trailing: Switch(
                trackOutlineColor: WidgetStateColor.resolveWith(
                  (final Set<WidgetState> states) {
                    if (states.contains(WidgetState.selected)) {
                      return Theme.of(context).colorScheme.primary;
                    }

                    return Colors.grey;
                  },
                ),
                inactiveThumbColor: Colors.grey[350],
                inactiveTrackColor: ColorManager.SCAFFOLD_BG,
                activeColor: Theme.of(context).colorScheme.primary,
                activeTrackColor: ColorManager.SCAFFOLD_BG,
                value: authValue.user.getSettings.alertsOn,
                onChanged: (value) async {
                  await changeAlerts(authValue, value, context);
                },
              ),
            ),
            addVerticalSpace(10),
            ListTile(
              onTap: () {
                print("Logout");
                showDialog(
                    context: context,
                    builder: (context) {
                      return LogoutDialogue();
                    });
              },
              leading: Icon(
                Icons.logout,
                size: 30,
                color: Colors.black,
              ),
              title: Text(
                "Logout",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        );
      }),
    );
  }
}
