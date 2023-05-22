import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SpeedIndicator extends StatelessWidget {
  final double speed;
  const SpeedIndicator({super.key, required this.speed});

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: [
        RadialAxis(
          maximum: 60,
          minimum: 0,
          interval: 5,
          ranges: [
            GaugeRange(
              startValue: 0,
              endValue: 20,
              color: Colors.green,
            ),
            GaugeRange(
              startValue: 20,
              endValue: 40,
              color: Colors.orange,
            ),
            GaugeRange(
              startValue: 40,
              endValue: 60,
              color: Colors.red,
            )
          ],
          pointers: [
            NeedlePointer(
              value: speed,
              enableAnimation: true,
              animationDuration: 2000,
            )
          ],
          annotations: [
            GaugeAnnotation(
              widget: Text(
                speed.toStringAsFixed(2),
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              positionFactor: 0.5,
              angle: 90,
            ),
          ],
        )
      ],
    );
  }
}
