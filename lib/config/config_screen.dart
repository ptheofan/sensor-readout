import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_sensors/config/config.dart';
import 'package:insta_sensors/config/sensor_config_sheet.dart';

import 'sensor_config.dart';

class ConfigScreen extends ConsumerWidget {
  const ConfigScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configNotifierProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Insta Readings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // open sensor add/edit bottom sheet
          showModalBottomSheet(
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
              context: context,
              builder: (context) {
                return const SensorConfigSheet();
              });
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            config.sensors.isEmpty
                ? const Center(
                    child: Text(
                      'No sensors have been configured.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ReorderableListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: config.sensors.length,
                    onReorder: (oldIndex, newIndex) {
                      SensorConfig sensor = config.sensors[oldIndex];
                      ref.read(configNotifierProvider.notifier).reorderSensor(sensor.uid, newIndex);
                    },
                    itemBuilder: (context, index) {
                      final SensorConfig sensor = config.sensors[index];
                      return Dismissible(
                        key: Key(sensor.uid),
                        background: Container(),
                        secondaryBackground: Container(
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Icon(Icons.delete, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                        confirmDismiss: (direction) async {
                          return direction == DismissDirection.endToStart;
                        },
                        onDismissed: (direction) {
                          if (direction == DismissDirection.endToStart) {
                            ref.read(configNotifierProvider.notifier).removeSensor(
                                sensor);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Sensor \"${sensor.name}\" removed")));
                          }
                        },
                        child: ListTile(
                          leading: sensorIcons[sensor.type] != null? Image.asset(sensorIcons[sensor.type]!) : const Icon(Icons.no_photography_outlined),
                          title: Text(sensor.name),
                          subtitle: Text("${sensor.host}:${sensor.port}"),
                          trailing: const Icon(Icons.drag_handle),
                          onTap: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                                ),
                                context: context,
                                builder: (context) {
                                  return SensorConfigSheet(sensor: sensor);
                                });
                          },
                        ),
                      );
                    }
                  ),
          ],
        ),
      ),
    );
  }
}
