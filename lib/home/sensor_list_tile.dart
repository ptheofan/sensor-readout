import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_sensors/home/gauge_vindrikthing.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('errors.cannotConnect').tr(),
                const Icon(Icons.error_outline_rounded, color: Colors.red, size: 40,),
              ],
            );
          },
          data: (v) {
            if (v.pm2 < 0) {
              return const Text('errors.deviceKeyMissing').tr(namedArgs: {'key': 'pm2.5'});
            } else {
              return SizedBox(
                width: 40,
                child: GaugeVindrikthing(radialNeedlePointer: NeedlePointer(
                  value: v.pm2.toDouble(),
                )),
              );
            }
          }
      ),
      title: Text(sensor.name),
      subtitle: Text("${sensor.host}:${sensor.port}"),
      onTap: () {
        // Refresh the individual sensor
        ref.read(selectedSensorProvider.notifier).state = sensor;
        homeBottomSheetKey.currentState?.expand();
      },
    );
  }
}