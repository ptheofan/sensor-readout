import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_sensors/config/config_screen.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Insta Readings'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ConfigScreen()));
        },
        child: const Icon(Icons.settings),
      ),
      body: config.sensors.isEmpty
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
                var values = ref.watch(sensorValuesNotifierProviderFamily(sensor.uid));

                return ListTile(
                  leading: sensorIcons[sensor.type] != null? Image.asset(sensorIcons[sensor.type]!) : const Icon(Icons.no_photography_outlined),
                  trailing: values.when(
                    loading: () => const CircularProgressIndicator(),
                    error: (err, stack) {
                      print(err);
                      return const Icon(Icons.error_outline_rounded, color: Colors.red);
                    },
                    data: (v) {
                      return Text(v.pm2.toString());
                    }
                  ),
                  title: Text(sensor.name),
                  subtitle: Text("${sensor.host}:${sensor.port}"),
                  onTap: () {
                    // Open in browser?
                  },
                );
              },
            ),
    );
  }
}
