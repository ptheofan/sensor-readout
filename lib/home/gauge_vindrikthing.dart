import 'package:flutter/material.dart';
import 'package:gauges/gauges.dart';

class GaugeVindrikthing extends StatelessWidget {
  final RadialNeedlePointer radialNeedlePointer;
  const GaugeVindrikthing({required this.radialNeedlePointer , Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: switch to https://pub.dev/packages/syncfusion_flutter_gauges/example
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
              radialNeedlePointer,
            ]
        ),
      ],
    );
  }
}