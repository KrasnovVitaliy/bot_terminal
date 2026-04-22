import 'package:flutter/material.dart';
import 'package:pod_terminal/constants.dart';
import 'package:hud_ui/hud_card.dart';
import 'package:hud_ui/hud_circular_progress.dart';

class ServosIndicatorlWidget extends StatelessWidget {
  final String title;
  final List<String> labels;
  final List<double> servos;
  final List<Color>? colors;
  final Color color;

  const ServosIndicatorlWidget({
    super.key,
    required this.title,
    required this.labels,
    required this.servos,
    this.colors,
    this.color = Colors.cyanAccent,
  });

  @override
  Widget build(BuildContext context) {
    return HudCard(
      title: title,
      color: primaryColor,
      child: Row(
        children: [
          for (int i = 0; i < servos.length; i++)
            HudCircularProgressIndicator(
              value: servos[i],
              minValue: 0,
              maxValue: 180,
              usePercentIndicator: false,
              icon: Icons.join_left,
              label: labels[i],
              linesCount: 0,
              color: colors != null ? colors![i]: color,
              size: 80,
            ),
        ],
      ),
    );
  }
}
