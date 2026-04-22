import 'package:flutter/material.dart';
import 'package:pod_terminal/constants.dart';
import 'package:pod_terminal/data/external_api/bot_api_client.dart';
import 'package:pod_terminal/presentation/widgets/commands.dart';
import 'package:pod_terminal/presentation/widgets/servos_control.dart';
import 'package:pod_terminal/presentation/widgets/servos_indicator.dart';
import 'package:pod_terminal/presentation/widgets/terminal_control.dart';
import 'package:pod_terminal/presentation/widgets/logs.dart';

class MainScreen extends StatefulWidget {
  final BotApiClient botApiClient;
  const MainScreen({super.key, required this.title, required this.botApiClient});

  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<double> servoPositions = [];

  @override
  void initState() {
    super.initState();
    servoPositions = [90, 180, 150, 90, 180, 150, 90, 180, 150, 90, 180, 150];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 8, vertical: 16),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 120, width: 1108, child: TerminalControlWidget(botApiClient: widget.botApiClient)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 220,
                  width: 550,
                  child: ServosIndicatorlWidget(
                    title: "Leg 1",
                    labels: ["Servo 5", "Servo 4", "Servo 3"],
                    servos: [servoPositions[5], servoPositions[4], servoPositions[3]],
                    colors: [Colors.limeAccent, Colors.cyanAccent, Colors.cyanAccent],
                  ),
                ),
                SizedBox(width: 8),
                SizedBox(
                  height: 220,
                  width: 550,
                  child: ServosIndicatorlWidget(
                    title: "Leg 0",
                    labels: ["Servo 0", "Servo 1", "Servo 2"],
                    servos: [servoPositions[0], servoPositions[1], servoPositions[2]],
                    colors: [Colors.cyanAccent, Colors.cyanAccent, Colors.limeAccent],
                  ),
                ),
              ],
            ),

            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 220,
                  width: 550,
                  child: ServosIndicatorlWidget(
                    title: "Leg 2",
                    labels: ["Servo 8", "Servo 7", "Servo 6"],
                    servos: [servoPositions[8], servoPositions[7], servoPositions[6]],
                    colors: [Colors.limeAccent, Colors.cyanAccent, Colors.cyanAccent],
                  ),
                ),
                SizedBox(width: 8),
                SizedBox(
                  height: 220,
                  width: 550,
                  child: ServosIndicatorlWidget(
                    title: "Leg 3",
                    labels: ["Servo 9", "Servo 10", "Servo 11"],
                    servos: [servoPositions[9], servoPositions[10], servoPositions[11]],
                    colors: [Colors.cyanAccent, Colors.cyanAccent, Colors.limeAccent],
                  ),
                ),
              ],
            ),

            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 300,
                  width: 1108,
                  child: ServosControlWidget(
                    servos: servoPositions,
                    onChanged: ({required servoNum, required value}) {
                      widget.botApiClient.updateAngle(servoNum: servoNum, angle: value.toInt()).then((onValue) {
                        setState(() {
                          servoPositions[servoNum] = value;
                        });
                      });
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [SizedBox(height: 120, width: 1108, child: CommandsWidget(botApiClient: widget.botApiClient))],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [SizedBox(height: 500, width: 1108, child: LogsWidget(title: "Logs"))],
            ),
          ],
        ),
      ),
    );
  }
}
