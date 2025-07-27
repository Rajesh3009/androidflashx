import 'package:flutter/material.dart';
import '../services/adb_service.dart';

class ApkInstallation extends StatefulWidget {
  @override
  _ApkInstallationState createState() => _ApkInstallationState();
}

class _ApkInstallationState extends State<ApkInstallation> {
  final AdbService adbService = AdbService();
  final TextEditingController apkFileController = TextEditingController();

  Future<void> installApk() async {
    try {
      await adbService.installApk(apkFileController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('APK installed successfully')),
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
        TextField(
          controller: apkFileController,
          decoration: InputDecoration(labelText: 'APK File Path'),
        ),
        ElevatedButton(
          onPressed: installApk,
          child: Text('Install APK'),
        ),
      ],
    );
  }
}