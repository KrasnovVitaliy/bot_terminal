import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:hud_ui/hud_button.dart';
import 'package:hud_ui/hud_card.dart';
import 'package:pod_terminal/data/external_api/bot_api_client.dart';

import 'package:pod_terminal/presentation/providers/bot.dart';
import 'package:pod_terminal/constants.dart';


class TerminalControlWidget extends StatelessWidget {
  final BotApiClient botApiClient;
  const TerminalControlWidget({super.key, required this.botApiClient});

  @override
  Widget build(BuildContext context) {
    return HudCard(
      title: "System",
      color: primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HudButton(
            label: context.watch<BotProvider>().isBotApiConnected ? "Disconnect" : "Connect",
            color: context.watch<BotProvider>().isBotApiConnected ? Colors.redAccent : Colors.limeAccent,
            onPressed: () {
              if (!context.read<BotProvider>().isBotApiConnected) {
                botApiClient.connect().onError((error, stack) {
                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(error.toString()),
                      duration: Duration(seconds: 3),
                      backgroundColor: errorColor.shade700,
                    ),
                  );
                });
              } else {
                botApiClient.disconnect();
              }
            },
          ),
        ],
      ),
    );
  }
}
