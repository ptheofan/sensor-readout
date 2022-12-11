import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauges/gauges.dart';

import '../config/sensor_config.dart';
import '../state/sensor_values.dart';
import 'gauge_vindrikthing.dart';
import 'home_screen.dart';

class SensorDetails extends ConsumerWidget {
  const SensorDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SensorConfig? selectedSensor = ref.watch(selectedSensorProvider);
    if (selectedSensor == null) {
      return const SizedBox.shrink();
    }

    return BottomSheet(
        enableDrag: false,
        onClosing: () {},
        builder: (context) {
          final values =
              ref.watch(sensorValuesNotifierProviderFamily(selectedSensor.uid));

          return SingleChildScrollView(
            child: Stack(alignment: Alignment.topRight, children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0)),
                  ),
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(selectedSensor.name, style: Theme.of(context).textTheme.headline6),
                        Text('Host ${selectedSensor.host}:${selectedSensor.port}'),
                        if (selectedSensor.username.isNotEmpty)
                          Text('With credentials (${selectedSensor.username})'),

                        SizedBox(
                            // TODO: Better calculate the size (constraints) for the gauge
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
                                Text('PM2.5: ${values.value?.pm2}', style: Theme.of(context).textTheme.headline6),
                              ],
                            ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Image.asset(sensorIcons[selectedSensor.type]!),
            ]),
          );
        });
  }
}
