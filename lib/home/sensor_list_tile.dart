import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauges/gauges.dart';

import '../config/sensor_config.dart';
import '../state/sensor_values.dart';

class SensorListTile extends ConsumerWidget {
  const SensorListTile({Key? key, required this.sensor}) : super(key: key);

  final SensorConfig sensor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final values = ref.watch(sensorValuesNotifierProviderFamily(sensor.uid));

    return ListTile(
      isThreeLine: false,
      leading: sensorIcons[sensor.type] != null? Image.asset(sensorIcons[sensor.type]!) : const Icon(Icons.no_photography_outlined),
      trailing: values.when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) {
            return const Icon(Icons.error_outline_rounded, color: Colors.red);
          },
          data: (v) {
            if (v.pm2 < 0) {
              return const Text('Unreadable');
            } else {
              return RadialGauge(
                axes: [
                  RadialGaugeAxis(
                    color: Colors.transparent,
                    minValue: 0,
                    maxValue: 1000,
                    minAngle: -150,
                    maxAngle: 150,
                    radius: 0.6,
                    width: 0.2,
                    segments: [
                      const RadialGaugeSegment(
                        minValue: 0,
                        maxValue: 12,
                        minAngle: -150,
                        maxAngle: -100,
                        color: Colors.green,
                      ),
                      const RadialGaugeSegment(
                        minValue: 13,
                        maxValue: 35,
                        minAngle: -99,
                        maxAngle: -40,
                        color: Colors.yellow,
                      ),
                      const RadialGaugeSegment(
                        minValue: 36,
                        maxValue: 150,
                        minAngle: -39,
                        maxAngle: 20,
                        color: Colors.orange,
                      ),
                      const RadialGaugeSegment(
                        minValue: 151,
                        maxValue: 250,
                        minAngle: 21,
                        maxAngle: 80,
                        color: Colors.purple,
                      ),
                      const RadialGaugeSegment(
                        minValue: 251,
                        maxValue: 1000,
                        minAngle: 81,
                        maxAngle: 150,
                        color: Colors.red,
                      ),
                    ],
                    pointers: [
                      RadialNeedlePointer(
                        value: v.pm2.toDouble(),
                        thicknessStart: 6,
                        thicknessEnd: 0,
                        length: 0.6,
                        knobRadius: 0.1,
                      ),
                    ]
                  ),
                ],
              );
            }

            // if (v.pm2 < 0) {
            //   return const Text('Unreadable');
            // } else if (v.pm2 <= 12) {
            //   return const Text('Good', style: TextStyle(color: Colors.green));
            // } else if (v.pm2 <= 35) {
            //   return const Text('Moderate', style: TextStyle(color: Colors.yellow));
            // } else if (v.pm2 <= 150) {
            //   return const Text('Unhealthy', style: TextStyle(color: Colors.orange));
            // } else if (v.pm2 <= 250) {
            //   return const Text('Very Unhealthy', style: TextStyle(color: Colors.purple));
            // } else {
            //   return const Text('Hazardous', style: TextStyle(color: Colors.red));
            // }
          }
      ),
      title: Text(sensor.name),
      subtitle: Text("${sensor.host}:${sensor.port}"),
      onTap: () {
        // Refresh the individual sensor
        ref.invalidate(sensorValuesNotifierProviderFamily(sensor.uid));
      },
    );
  }
}