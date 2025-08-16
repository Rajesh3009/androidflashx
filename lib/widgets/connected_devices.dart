import 'package:flutter/material.dart';
import '../services/adb_service.dart';

class ConnectedDevices extends StatefulWidget {
 const ConnectedDevices({super.key});

 @override
 State<ConnectedDevices> createState() => _ConnectedDevicesState();
}

class _ConnectedDevicesState extends State<ConnectedDevices> {
 final AdbService adbService = AdbService();
 List<String>? _devices;
 String? _selectedDeviceId;

 @override
 void initState() {
  super.initState();
  _fetchDevices();
 }

 Future<void> _fetchDevices() async {
  try {
   // Use "-l" to get more info like product/model
   final result = await adbService.executeAdbCommand(['devices', '-l']);

   final stdoutStr = (result.stdout ?? '').toString();
   print('ADB devices output:\n$stdoutStr');

   // Normalize line endings
   final lines = stdoutStr.replaceAll('\r\n', '\n').split('\n');

   final connectedDevices = <String>[];

   for (final rawLine in lines) {
    final line = rawLine.trim();
    if (line.isEmpty) continue;
    if (line.toLowerCase().startsWith('list of devices attached')) continue;

    // Split on any whitespace (handles tab/space)
    final parts = line.split(RegExp(r'\s+'));
    if (parts.length < 2) continue;

    final deviceId = parts[0];
    final status = parts[1].toLowerCase();

    // Accept ready or visible devices; you can filter here
    if (status == 'device' || status == 'unauthorized' || status == 'offline') {
     connectedDevices.add(deviceId);
    }
   }

   setState(() {
     _devices = connectedDevices;
    }
   );
  }
  catch (e, st) {
   debugPrint('Error fetching connected devices: $e\n$st');
   setState(() {
     _devices = [];
    }
   );
  }
 }

 @override
 Widget build(BuildContext context) {
  return _buildBody();
 }

 Widget _buildBody() {
  if (_devices == null) {
   return const Center(child: CircularProgressIndicator());
  }
  if (_devices!.isEmpty) {
   return const Center(child: Text('No devices connected or an error occurred'));
  }
  return Row(
   children: [
    const Text('Connected Devices:', style: TextStyle(fontSize: 18)),
    DropdownButton<String>(
     value: _selectedDeviceId,
     hint: const Text('Select a device'),
     items: _devices!.map((deviceId) {
       return DropdownMenuItem<String>(
        value: deviceId,
        child: Text(deviceId)
       );
      }
     ).toList(),
     onChanged: (value) {
      setState(() {
        _selectedDeviceId = value;
       }
      );
     }
    ),
    Spacer(),
    ElevatedButton(
     onPressed: _fetchDevices,
     child: const Text('Refresh Devices')
    )
   ]
  );
 }
}
