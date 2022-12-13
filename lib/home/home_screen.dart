import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_sensors/config/config_screen.dart';
import 'package:insta_sensors/home/home_empty.dart';
import 'package:insta_sensors/home/sensor_details.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Now'),
      ),
      floatingActionButton: Opacity(
        opacity: selectedSensor == null ? 1 : 0,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ConfigScreen()));
          },
          child: const Icon(Icons.settings),
        ),
      ),
      body: Builder(builder: (context) {
        if (config.sensors.isEmpty) {
          return const HomeEmpty();
        }

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(sensorValuesNotifierProviderFamily);
          },
          child: Stack(
            children: [
              SafeArea(
                child: ListView.builder(
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
              ),
              ExpandableBottomSheet(
                key: homeBottomSheetKey,
                background: const SizedBox(),
                expandableContent: const SensorDetails(),
                onIsContractedCallback: () {
                  ref.read(selectedSensorProvider.notifier).state = null;
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}

final selectedSensorProvider =
    StateProvider.autoDispose<SensorConfig?>((ref) => null);

final GlobalKey<ExpandableBottomSheetState> homeBottomSheetKey = GlobalKey();