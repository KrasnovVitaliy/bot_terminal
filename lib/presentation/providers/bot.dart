import 'package:flutter/foundation.dart';

class BotProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isBotApiConnected = false;

  bool get isBotApiConnected => _isBotApiConnected;

  void setBotApiConnectionState(bool state) {
    _isBotApiConnected = state;
    notifyListeners();
  }
}
