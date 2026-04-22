import 'dart:io';
import 'dart:async';

import 'package:pod_terminal/domain/commands.dart';
import 'package:pod_terminal/constants.dart';

class BotApiClient {
  String host;
  int port;
  Socket? socket;
  Function({bool state}) onConnectionStateChanged;
  Function({required String message, required String logType}) onLogMessage;

  Timer? _throttleTimer;

  BotApiClient({
    required this.onConnectionStateChanged,
    required this.onLogMessage,
    this.host = "127.0.0.1",
    this.port = 5566,
  });

  Future<void> connect() async {
    try {
      final s = await Socket.connect(host, port);
      onConnectionStateChanged(state: true);
      onLogMessage(message: "Connected to server: $host:$port", logType: logTypeInfo);
      socket = s;

      socket!.listen(
        (data) {
          final message = String.fromCharCodes(data).trim();

          if (message.startsWith('id')) {
            final response = handleIdCommand(message);
            sendCommand(response);
          }
        },
        onDone: () {
          socket = null;
          onConnectionStateChanged(state: false);
        },
        onError: (e) {
          socket = null;
          onConnectionStateChanged(state: false);
          onLogMessage(message: e.toString(), logType: logTypeError);
        },
      );
    } catch (e) {
      socket = null;
      onConnectionStateChanged(state: false);
      onLogMessage(message: e.toString(), logType: logTypeError);
      rethrow;
    }
  }

  Future<void> disconnect() async {
    await socket?.close();
    socket = null;
    onConnectionStateChanged(state: false);
    onLogMessage(message: "Disconnected from server", logType: logTypeInfo);
  }

  Future<void> sendCommand(String cmd) async {
    try {
      if (socket != null) {
        socket!.write('$cmd\n');
        await socket!.flush();
      }
    } catch (e) {
      rethrow;
    }
  }

  bool isConnected() {
    return socket != null;
  }

  String handleIdCommand(String message) {
    return 'id:terminal:2';
  }

  // Commands
  Future<void> updateAngle({required int servoNum, required int angle}) async {
    _throttleTimer?.cancel();
    _throttleTimer = Timer(Duration(milliseconds: 10), () async {
      await sendCommand("$servoAngleCommand=$servoNum,$angle");
    });
  }

  Future<void> getStatus() async {
    await sendCommand(statusCommand);
  }

  Future<void> setStand() async {
    await sendCommand(standCommand);
  }

  Future<void> setUp() async {
    await sendCommand(upCommand);
  }

  Future<void> setDown() async {
    await sendCommand(downCommand);
  }

  Future<void> setPulse() async {
    await sendCommand(pulseCommand);
  }

  Future<void> setBase() async {
    await sendCommand(baseCommand);
  }
}
