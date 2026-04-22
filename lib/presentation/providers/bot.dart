import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class BotProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isBotApiConnected = false;

  bool get isBotApiConnected => _isBotApiConnected;

  void setBotApiConnectionState(bool state) {
    _isBotApiConnected = state;
    notifyListeners();
  }

  List<Map<String, String>> _logs = [];
  List<Map<String, String>> get logs => _logs;
  final int _maxLogsCount = 500;

  void addLog({required String message, String logType = "info"}) {
    logs.add({"time": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()), "type": logType, "message": message});
    if (logs.length > _maxLogsCount) {
      logs.removeAt(0);
    }
  }
}
