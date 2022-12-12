import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_sensors/config/config_screen.dart';
import 'package:insta_sensors/home/sensor_list_tile.dart';

import '../config/config.dart';
import '../config/sensor_config.dart';
import '../state/sensor_values.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    // Load the settings
    ref.read(configNotifierProvider.notifier).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Config config = ref.watch(configNotifierProvider);
    final SensorConfig? selectedSensor = ref.watch(selectedSensorProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(sensorValuesNotifierProviderFamily);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Insta Readings'),
        ),
        body: Stack(children: [
          config.sensors.isEmpty
              ? const Center(
                  child: Text(
                    'No sensors have been configured.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                itemCount: config.sensors.length,
                itemBuilder: (context, index) {
                  final SensorConfig sensor = config.sensors[index];
                  return Dismissible(
                    key: Key(sensor.uid),
                    background: Container(),
                    secondaryBackground: Container(
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(Icons.refresh, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      return direction == DismissDirection.endToStart;
                    },
                    onDismissed: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        ref.invalidate(
                            sensorValuesNotifierProviderFamily(sensor.uid));
                      }
                    },
                    child: SensorListTile(sensor: sensor),
                  );
                },
              ),
            Positioned(
              bottom: 50,
              right: 15,
              child: selectedSensor == null ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ConfigScreen()));
                },
                child: const Icon(Icons.settings),
              ) : Container(),
            )
        ]),
      ),
    );
  }
}

final selectedSensorProvider = StateProvider.autoDispose<SensorConfig?>((ref) => null);
