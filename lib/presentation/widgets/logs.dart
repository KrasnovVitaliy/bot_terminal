import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:hud_ui/hud_card.dart';

import 'package:pod_terminal/presentation/providers/bot.dart';
import 'package:pod_terminal/constants.dart';

class LogsWidget extends StatelessWidget {
  final String title;
  final Color color;
  final ScrollController _scrollController = ScrollController();

  LogsWidget({super.key, required this.title, this.color = Colors.cyanAccent});

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Widget buildLogs(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    return ListView.builder(
      controller: _scrollController,
      itemCount: context.watch<BotProvider>().logs.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final log = context.watch<BotProvider>().logs[index];

        final time = log["time"] ?? "";
        final type = (log["type"] ?? "info").toUpperCase();
        final message = log["message"] ?? "";

        Color typeColor;
        switch (type.toLowerCase()) {
          case 'error':
            typeColor = Colors.redAccent;
            break;
          case 'warning':
            typeColor = Colors.orangeAccent;
            break;
          case 'info':
            typeColor = Colors.limeAccent;
            break;
          default:
            typeColor = primaryColor;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          child: Text.rich(
            TextSpan(
              style: TextStyle(color: primaryColor.withAlpha(179)),
              children: [
                TextSpan(
                  text: time,
                  style: TextStyle(color: Colors.grey),
                ),
                TextSpan(text: ' '),
                TextSpan(
                  text: '[$type]',
                  style: TextStyle(color: typeColor),
                ),
                TextSpan(text: ': '),
                TextSpan(text: message),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return HudCard(
      title: "Logs",
      color: primaryColor,
      height: 300,
      child: Expanded(child: buildLogs(context)),
    );
  }
}
