import 'package:flutter/material.dart';
import 'package:hivemind_app/models/apiary.model.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';

class LocationCard extends StatefulWidget {
  const LocationCard({super.key, required this.apiary});
  final Apiary apiary;

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  var weather = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
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
                    Theme.of(context).iconTheme.color),
                Flexible(
                  child: Tooltip(
                    verticalOffset: 40,
                    margin: EdgeInsets.all(10),
                    message: widget.apiary.getLocation(),
                    child: Text(widget.apiary.getLocation(),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
            Row(
              spacing: 10,
              children: [
                iconBox(Icons.cloud_queue, Theme.of(context).iconTheme.color),
                Text(
                  widget.apiary.weather!,
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
