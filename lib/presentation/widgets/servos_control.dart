import 'package:flutter/material.dart';
import 'package:pod_terminal/constants.dart';
import 'package:hud_ui/hud_card.dart';
import 'package:hud_ui/hud_vertical_knob.dart';

class ServosControlWidget extends StatelessWidget {
  final List<double> servos;
  final Function({required int servoNum, required double value}) onChanged;

  const ServosControlWidget({super.key, required this.servos, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return HudCard(
      title: "Servos control",
      color: primaryColor,
      child: Row(
        children: [
          for (int i = 0; i < servos.length; i++)
            Expanded(
              child: HudVerticalKnob(
                value: servos[i],
                min: 0,
                max: 180,
                color: [2, 5, 8, 11].contains(i) ? secondaryColor : primaryColor,
                valuePosition: ValuePositionVertical.bottom,
                label: "Servo $i",
                onChanged: (value) {
                  onChanged(servoNum: i, value: value);
                },
              ),
            ),
        ],
      ),
    );
  }
}
