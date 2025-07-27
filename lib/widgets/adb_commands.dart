import 'package:flutter/material.dart';
import '../services/adb_service.dart';

class AdbCommands extends StatefulWidget {
  @override
  _AdbCommandsState createState() => _AdbCommandsState();
}

class _AdbCommandsState extends State<AdbCommands> {
  final AdbService adbService = AdbService();

  Future<void> executeCommand(String command) async {
    try {
      final result = await adbService.executeAdbCommand([command]);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Command output: ${result.stdout}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => executeCommand('reboot'),
          child: Text('Reboot Device'),
        ),
        ElevatedButton(
          onPressed: () => executeCommand('shell pm list packages'),
          child: Text('List Packages'),
        ),
        ElevatedButton(
          onPressed: () => executeCommand('shell pm disable com.example.app'),
          child: Text('Disable App'),
        ),
        ElevatedButton(
          onPressed: () => executeCommand('shell pm enable com.example.app'),
          child: Text('Enable App'),
        ),
      ],
    );
  }
}