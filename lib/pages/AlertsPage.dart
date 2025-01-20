import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/alerts.provider.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:hivemind_app/widgets/general/AlertsList.dart';
import 'package:hivemind_app/widgets/general/ClearTextBtn.dart';
import 'package:hivemind_app/widgets/general/NavBar.dart';
import 'package:hivemind_app/widgets/general/empty.state.dart';
import 'package:provider/provider.dart';

class AlertsPage extends StatefulWidget {
  const AlertsPage({super.key});

  @override
  State<AlertsPage> createState() => _AlertsPageState();
}

Future clearRead({context}) async {
  try {
    await Provider.of<Alerts>(context, listen: false)
        .markRead(context: context);
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Clear alerts failed: ${error.toString()}'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

class _AlertsPageState extends State<AlertsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Alerts"),
        ),
        body: Consumer<Alerts>(
            builder: (BuildContext context, Alerts value, Widget? child) {
          return value.alerts.isEmpty
              ? EmptyState(context: context)
              : Column(
                  children: [
                    addVerticalSpace(24),
                    ClearTextBtn(context, "Clear All Alerts", () {
                      clearRead(context: context);
                    }),
                    AlertsList(
                      alerts: value.alerts,
                    )
                  ],
                );
        }));
  }
}
