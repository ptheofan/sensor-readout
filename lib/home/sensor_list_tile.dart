import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauges/gauges.dart';
import 'package:insta_sensors/home/gauge_vindrikthing.dart';
import 'package:insta_sensors/home/sensor_details.dart';

import '../config/sensor_config.dart';
import '../state/sensor_values.dart';
import 'home_screen.dart';

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
              return GaugeVindrikthing(radialNeedlePointer: RadialNeedlePointer(
                value: v.pm2.toDouble(),
                thicknessStart: 6,
                thicknessEnd: 0,
                length: 0.6,
                knobRadius: 0.1,
              ));
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
        ref.read(selectedSensorProvider.notifier).state = sensor;
        Scaffold.of(context).showBottomSheet((context) => const SensorDetails());
      },
    );
  }
}