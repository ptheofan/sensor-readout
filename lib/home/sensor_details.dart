import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauges/gauges.dart';

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
      SingleChildScrollView(
        child: Padding(
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
                        GaugeVindrikthing(
                            radialNeedlePointer: RadialNeedlePointer(
                          value: values.value?.pm2.toDouble() ?? 0,
                          thicknessStart: 6,
                          thicknessEnd: 0,
                          length: 0.6,
                          knobRadius: 0.1,
                        )),
                        if (values.value != null)
                          _colorGradedValue(values.value!),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: Text('Host ${selectedSensor.host}:${selectedSensor.port}'),),
                      if (selectedSensor.username.isNotEmpty)
                        Text('With credentials (${selectedSensor.username})'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      Image.asset(sensorIcons[selectedSensor.type]!),
    ]);
  }

  Widget _colorGradedValue(SensorValues values) {
    const TextStyle textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    if (values.pm2 < 0) {
      return const Text('(Unreadable)', style: textStyle);
    } else if (values.pm2 <= 12) {
      return Text('${values.pm2.toString()} (Good)', style: textStyle.copyWith(color: Colors.green));
    } else if (values.pm2 <= 35) {
      return Text('${values.pm2.toString()} (Moderate)', style: textStyle.copyWith(color: Colors.yellow));
    } else if (values.pm2 <= 150) {
      return Text('${values.pm2.toString()} (Unhealthy)', style: textStyle.copyWith(color: Colors.orange));
    } else if (values.pm2 <= 250) {
      return Text('${values.pm2.toString()} (Very Unhealthy)', style: textStyle.copyWith(color: Colors.purple));
    } else {
      return Text('${values.pm2.toString()} (Hazardous)', style: textStyle.copyWith(color: Colors.red));
    }
  }
}
