import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pod_terminal/presentation/screens/main_screen.dart';
import 'package:pod_terminal/presentation/providers/bot.dart';
import 'package:pod_terminal/data/external_api/bot_api_client.dart';

void main() {
  final botProvider = BotProvider();
  final botApiClient = BotApiClient(
    onConnectionStateChanged: ({bool? state}) => botProvider.setBotApiConnectionState(state ?? false),
    onLogMessage: ({required String message, required String logType}) =>
        botProvider.addLog(message: message, logType: logType),
  );

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider.value(value: botProvider)],
      child: MyApp(botApiClient: botApiClient),
    ),
  );
}

class MyApp extends StatelessWidget {
  final BotApiClient botApiClient;
  const MyApp({super.key, required this.botApiClient});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pod Terminal',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.cyanAccent)),
      home: MainScreen(title: 'Pod Terminal', botApiClient: botApiClient),
    );
  }
}
