import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../config/sensor_config.dart';
import '../state/sensor_values.dart';
import 'gauge_vindrikthing.dart';
import 'home_screen.dart';

class SensorDetails extends ConsumerStatefulWidget {
  const SensorDetails({Key? key}) : super(key: key);

  @override
  SensorDetailsState createState() => SensorDetailsState();
}

class SensorDetailsState extends ConsumerState<SensorDetails>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final SensorConfig? selectedSensor = ref.watch(selectedSensorProvider);
    if (selectedSensor == null) {
      return Container();
    }

    final values =
        ref.watch(sensorValuesNotifierProviderFamily(selectedSensor.uid));
    return Stack(alignment: Alignment.topRight, children: [
      Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(selectedSensor.name,
                    style: Theme.of(context).textTheme.headline6),
                Text(sensorTypes[selectedSensor.type]!,
                    style: Theme.of(context).textTheme.subtitle1),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.9 + 50,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      GaugeVindrikthing(
                          miniMode: false,
                          radialNeedlePointer: NeedlePointer(
                            value: values.value?.pm2.toDouble() ?? 0,
                          )),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          'Host ${selectedSensor.host}:${selectedSensor.port}'),
                    ),
                    if (selectedSensor.username.isNotEmpty)
                      Text('With credentials (${selectedSensor.username})'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      Image.asset(sensorIcons[selectedSensor.type]!),
    ]);
  }
}
