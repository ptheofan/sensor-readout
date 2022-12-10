import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/sensor_config.dart';
import '../state/sensor_values.dart';

class SensorListTile extends ConsumerWidget {
  const SensorListTile({Key? key, required this.sensor}) : super(key: key);

  final SensorConfig sensor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final values = ref.watch(sensorValuesNotifierProviderFamily(sensor.uid));

    return ListTile(
      leading: sensorIcons[sensor.type] != null? Image.asset(sensorIcons[sensor.type]!) : const Icon(Icons.no_photography_outlined),
      trailing: values.when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) {
            return const Icon(Icons.error_outline_rounded, color: Colors.red);
          },
          data: (v) {
            if (v.pm2 < 0) {
              return Text(v.pm2.toString());
            }
            return Text(v.pm2.toString());
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