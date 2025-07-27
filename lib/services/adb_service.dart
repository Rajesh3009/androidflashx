import 'package:process_run/shell.dart';
import 'dart:io';

class AdbService {
  Future<ProcessResult> executeAdbCommand(List<String> arguments) async {
    try {
      final result = await runExecutableArguments('adb', arguments);
      if (result.exitCode != 0) {
        throw Exception('ADB command failed: ${result.stderr}');
      }
      return result;
    } catch (e) {
      throw Exception('Error executing ADB command: $e');
    }
  }

  Future<ProcessResult> pushFile(String localPath, String remotePath) async {
    return await executeAdbCommand(['push', localPath, remotePath]);
  }

  Future<ProcessResult> pullFile(String remotePath, String localPath) async {
    return await executeAdbCommand(['pull', remotePath, localPath]);
  }

  Future<ProcessResult> installApk(String apkPath) async {
    return await executeAdbCommand(['install', apkPath]);
  }
}