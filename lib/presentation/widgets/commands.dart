import 'package:flutter/material.dart';
import 'package:pod_terminal/constants.dart';
import 'package:pod_terminal/domain/commands.dart';
import 'package:pod_terminal/data/external_api/bot_api_client.dart';

import 'package:hud_ui/hud_button.dart';
import 'package:hud_ui/hud_card.dart';

class CommandsWidget extends StatelessWidget {
  final BotApiClient botApiClient;
  const CommandsWidget({super.key, required this.botApiClient});

  @override
  Widget build(BuildContext context) {
    return HudCard(
      title: "Commands",
      color: primaryColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HudButton(
              label: "stand",
              color: primaryColor,
              onPressed: () {
                botApiClient.setStand();
              },
            ),
            SizedBox(width: 16),
            HudButton(
              label: "up",
              color: primaryColor,
              onPressed: () {
                botApiClient.setUp();
              },
            ),
            SizedBox(width: 16),
            HudButton(
              label: "down",
              color: primaryColor,
              onPressed: () {
                botApiClient.setDown();
              },
            ),
            SizedBox(width: 16),
            HudButton(
              label: "pulse",
              color: primaryColor,
              onPressed: () {
                botApiClient.setPulse();
              },
            ),
            SizedBox(width: 16),
            HudButton(
              label: "base",
              color: primaryColor,
              onPressed: () {
                botApiClient.setBase();
              },
            ),
          ],
        ),
      ),
    );
  }
}
