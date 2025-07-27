import 'package:flutter/material.dart';
import '../services/adb_service.dart';

class FileOperations extends StatefulWidget {
  @override
  _FileOperationsState createState() => _FileOperationsState();
}

class _FileOperationsState extends State<FileOperations> {
  final AdbService adbService = AdbService();
  final TextEditingController localFileController = TextEditingController();
  final TextEditingController remoteFileController = TextEditingController();
  String operationType = 'push';

  Future<void> executeFileOperation() async {
    try {
      if (operationType == 'push') {
        await adbService.pushFile(localFileController.text, remoteFileController.text);
      } else {
        await adbService.pullFile(remoteFileController.text, localFileController.text);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File operation successful')),
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
        DropdownButton<String>(
          value: operationType,
          onChanged: (String? newValue) {
            setState(() {
              operationType = newValue!;
            });
          },
          items: <String>['push', 'pull']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value == 'push' ? 'Push File' : 'Pull File'),
            );
          }).toList(),
        ),
        TextField(
          controller: localFileController,
          decoration: InputDecoration(labelText: 'Local File Path'),
        ),
        TextField(
          controller: remoteFileController,
          decoration: InputDecoration(labelText: 'Remote File Path'),
        ),
        ElevatedButton(
          onPressed: executeFileOperation,
          child: Text('Execute File Operation'),
        ),
      ],
    );
  }
}