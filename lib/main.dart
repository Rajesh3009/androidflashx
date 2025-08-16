import 'package:flutter/material.dart';
import 'services/adb_service.dart';
import 'services/fastboot_service.dart';
import 'widgets/connected_devices.dart';
import 'widgets/adb_commands.dart';
import 'widgets/file_operations.dart';
import 'widgets/apk_installation.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('ADB/Fastboot Tool'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'ADB Operations'),
                Tab(text: 'Fastboot Operations'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              AdbOperations(),
              // Container(),
              FastbootOperations(),
            ],
          ),
        ),
      ),
    );
  }
}

class AdbOperations extends StatelessWidget {
  final AdbService adbService = AdbService();

  AdbOperations({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConnectedDevices(),
        AdbCommands(),
        FileOperations(),
        ApkInstallation(),
      ],
    );
  }
}

class FastbootOperations extends StatelessWidget {
  final FastbootService fastbootService = FastbootService();

  FastbootOperations({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Fastboot Operations will be here'),
    );
  }
}
