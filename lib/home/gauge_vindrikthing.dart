import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RangeMap {
  final double min;
  final double max;
  final double width;
  final Color? color;
  final double? startWidth;
  final double? endWidth;
  final Gradient? gradient;
  final double rangeOffset;
  final String? label;
  final GaugeTextStyle? labelStyle;

  RangeMap(
    this.min,
    this.max,
    this.width, {
    this.color,
    this.startWidth,
    this.endWidth,
    this.gradient,
    this.rangeOffset = 0,
    this.label,
    this.labelStyle,
  });
}

class GaugeVindrikthing extends StatelessWidget {
  final NeedlePointer radialNeedlePointer;
  final bool miniMode;

  GaugeVindrikthing(
      {required this.radialNeedlePointer,
      this.miniMode = true,
      Key? key})
      : super(key: key);

  final List<RangeMap> rangeMap = [
    RangeMap(0, 12, 200, color: Colors.green, label: 'Good'),
    RangeMap(12, 35, 200, color: Colors.yellow, label: 'Moderate'),
    RangeMap(35, 150, 200, color: Colors.orange, label: 'Unhealthy'),
    RangeMap(150, 250, 200, color: Colors.purple, label: 'Very Unhealthy'),
    RangeMap(200, 1000, 200, color: Colors.red, label: 'Hazardous'),
  ];

  List<GaugeRange> _getRanges() {
    // Move to cached data function
    List<GaugeRange> ranges = [];
    double maxt = 0.0;
    for (final range in rangeMap) {
      if (miniMode) {
        ranges.add(GaugeRange(
          startValue: maxt,
          endValue: maxt + range.width,
          startWidth: miniMode ? 4 : 10,
          endWidth: miniMode ? 4 : 10,
          color: range.color,
        ));
      } else {
        ranges.add(GaugeRange(
          startValue: maxt,
          endValue: maxt + range.width,
          startWidth: miniMode ? 4 : 20,
          endWidth: miniMode ? 4 : 20,
          color: range.color,
          // label: range.label,
          // labelStyle: GaugeTextStyle(
          //   fontSize: 12,
          //   fontWeight: FontWeight.bold,
          //   color: range.color,
          // ),
        ));
      }


      maxt += range.width;
    }

    return ranges;
  }

  /// Compute the correct needle value for the gauge from the actual sensor value
  _mapValue(double v) {
    double maxt = 0.0;
    double prevMax = 0;
    for (final range in rangeMap) {
      if (v >= range.min && v <= range.max) {
        return ((v - prevMax) * range.width / (range.max - range.min) + maxt);
      }

      maxt += range.width;
      prevMax = range.max;
    }
  }

  RangeMap? _range(double value) {
    return rangeMap.firstWhere((element) => value >= element.min && value <= element.max);
  }

  Color? _color(double value) {
    if (value < 0) {
      return null;
    }

    return _range(value)?.color;
  }

  String? _label(double value) {
    if (value < 0) {
      return 'Unreadable';
    }

    return _range(value)?.label;
  }

  Text _textAnnotation(double value) {
    const TextStyle textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

    if (value < 0) {
      return const Text('(Unreadable)', style: textStyle);
    }

    return Text('${_label(value)} (${value.toInt()})', style: textStyle.copyWith(color: _color(value)));
  }

  @override
  Widget build(BuildContext context) {
    final v = radialNeedlePointer.value;
    final List<GaugeRange> ranges = _getRanges();
    final pointer = NeedlePointer(
      value: _mapValue(v),
      needleStartWidth: miniMode ? 1 : 1,
      needleEndWidth: miniMode ? 3 : 10,
      needleLength: miniMode ? 0.5 : 0.8,
      knobStyle: const KnobStyle(
        knobRadius: 0.1,
      ),
    );

    List<GaugeAnnotation> annotations = [];
    if (!miniMode) {
      annotations.add(GaugeAnnotation(
          widget: Container(child: _textAnnotation(v)),
          angle: 90,
          positionFactor: 0.5));
    }

    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
            minimum: 0,
            maximum: 1000,
            canScaleToFit: false,
            showFirstLabel: false,
            showAxisLine: false,
            showLabels: false,
            showTicks: false,
            annotations: annotations,
            ranges: ranges,
            pointers: [
              pointer,
            ])
      ],
    );
  }
}
