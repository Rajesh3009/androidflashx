import 'package:flutter/material.dart';
import '../services/fastboot_service.dart';

class FastbootCommands extends StatefulWidget {
  @override
  _FastbootCommandsState createState() => _FastbootCommandsState();
}

class _FastbootCommandsState extends State<FastbootCommands> {
  final FastbootService fastbootService = FastbootService();
  final TextEditingController filePathController = TextEditingController();

  Future<void> executeCommand(String command) async {
    try {
      final result = await fastbootService.executeFastbootCommand([command]);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Command output: ${result.stdout}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> flashFile() async {
    try {
      await fastbootService.flashFile(filePathController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File flashed successfully')),
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
          child: Text('Reboot Bootloader'),
        ),
        ElevatedButton(
          onPressed: () => executeCommand('erase userdata'),
          child: Text('Erase Userdata'),
        ),
        TextField(
          controller: filePathController,
          decoration: InputDecoration(labelText: 'File Path to Flash'),
        ),
        ElevatedButton(
          onPressed: flashFile,
          child: Text('Flash File'),
        ),
      ],
    );
  }
}