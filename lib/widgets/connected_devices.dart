import 'package:flutter/material.dart';
import '../services/adb_service.dart';

class ConnectedDevices extends StatelessWidget {
  final AdbService adbService = AdbService();

  Future<List<String>> getConnectedDevices() async {
    try {
      final result = await adbService.executeAdbCommand(['devices']);
      return result.stdout.split('\n').where((line) => line.contains('\tdevice')).map((line) => line.split('\t')[0]).toList();
    } catch (e) {
      throw Exception('Error fetching connected devices: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: getConnectedDevices(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No devices connected'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index]),
              );
            },
          );
        }
      },
    );
  }
}