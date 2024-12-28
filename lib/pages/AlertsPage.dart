import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:hivemind_app/widgets/general/AlertsList.dart';
import 'package:hivemind_app/widgets/general/ClearTextBtn.dart';
import 'package:hivemind_app/widgets/general/NavBar.dart';

class AlertsPage extends StatefulWidget {
  const AlertsPage({super.key});

  @override
  State<AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alerts"),
      ),
      body: Column(
        children: [
          addVerticalSpace(24),
          ClearTextBtn(context, "Mark All as Read", () {}),
        ],
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}
