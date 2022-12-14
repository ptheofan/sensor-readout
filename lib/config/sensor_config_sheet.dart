import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_sensors/config/sensor_config.dart';
import 'package:uuid/uuid.dart';

import 'config.dart';

class SensorConfigSheet extends ConsumerStatefulWidget {
  final SensorConfig? sensor;

  const SensorConfigSheet({this.sensor, Key? key}) : super(key: key);

  @override
  SensorConfigSheetState createState() => SensorConfigSheetState();
}

class SensorConfigSheetState extends ConsumerState<SensorConfigSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _hostCtrl = TextEditingController();
  final _portCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  SensorType? _sensorType;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    if (widget.sensor != null) {
      _nameCtrl.text = widget.sensor?.name ?? '';
      _hostCtrl.text = widget.sensor?.host ?? '';
      _portCtrl.text = widget.sensor?.port.toString() ?? '';
      _usernameCtrl.text = widget.sensor?.username ?? '';
      _passwordCtrl.text = widget.sensor?.password ?? '';
      _sensorType = widget.sensor?.type;
    } else {
      _portCtrl.text = '80';
    }
  }

  saveSensor() {
    Uuid uuid = const Uuid();
    SensorConfig sensor = SensorConfig(
      uid: widget.sensor?.uid ?? uuid.v1(),
      name: _nameCtrl.text,
      host: _hostCtrl.text,
      port: int.parse(_portCtrl.text),
      username: _usernameCtrl.text,
      password: _passwordCtrl.text,
      type: _sensorType ?? SensorType.tasmotaVindrikthing,
    );
    ref.read(configNotifierProvider.notifier).setSensor(sensor);
  }

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DropdownButtonFormField<SensorType>(
                        value: _sensorType,
                        decoration: InputDecoration(labelText: 'sensorConfigForm.sensorType'.tr()),
                        items: sensorTypes.keys
                            .map<DropdownMenuItem<SensorType>>((SensorType key) {
                          return DropdownMenuItem<SensorType>(
                            value: key,
                            child: Text(sensorTypes[key]!),
                          );
                        }).toList(growable: false),
                        onChanged: (SensorType? newValue) {
                          setState(() {
                            _sensorType = newValue;
                          });
                        },
                      ),
                      TextFormField(
                        controller: _nameCtrl,
                        decoration: InputDecoration(labelText: 'sensorConfigForm.sensorName'.tr()),
                      ),
                      Row(children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: _hostCtrl,
                            decoration: InputDecoration(labelText: 'sensorConfigForm.host'.tr()),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _portCtrl,
                            decoration: InputDecoration(labelText: 'sensorConfigForm.port'.tr()),
                          ),
                        ),
                      ]),
                      Row(children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: _usernameCtrl,
                            decoration: InputDecoration(labelText: 'sensorConfigForm.username'.tr()),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextFormField(
                            obscureText: _obscurePassword,
                            controller: _passwordCtrl,
                            decoration: InputDecoration(
                                labelText: 'sensorConfigForm.password'.tr(),
                                suffixIcon: IconButton(
                                    icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                ),
                            ),
                          ),
                        ),
                      ]),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                              child: ElevatedButton(
                                  onPressed: () {
                                    // Save data
                                    saveSensor();
                                    // Close modal bottom sheet
                                    Navigator.pop(context);
                                    // Show snackbar
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content:
                                            Text('messages.sensorConfigSaved'.tr(namedArgs: {'sensorName': _nameCtrl.text}))));
                                  },
                                  child: const Text('buttons.save').tr())),
                          const SizedBox(
                            width: 8,
                          ),
                          Flexible(
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('buttons.cancel').tr())),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
        ),
      );
  }
}
