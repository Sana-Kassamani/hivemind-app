import 'package:flutter/material.dart';
import 'package:hivemind_app/models/apiary.model.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:hivemind_app/utils/colors.dart';
import 'package:provider/provider.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({super.key, required this.apiary});
  final Apiary apiary;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.CARD_BG,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          children: [
            Row(
              spacing: 10,
              children: [
                iconBox(Icons.location_on_outlined,
                    Theme.of(context).colorScheme.primary),
                Text(
                  apiary.getLocation(),
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              spacing: 10,
              children: [
                iconBox(
                    Icons.cloud_queue, Theme.of(context).colorScheme.primary),
                Text(
                  "Sunny",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
