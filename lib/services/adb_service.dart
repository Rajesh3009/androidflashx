import 'package:process_run/shell.dart';
import 'dart:io';

  /// A service class for executing ADB (Android Debug Bridge) commands.
  ///
  /// Provides methods to interact with Android devices via ADB.
  class AdbService {
  /// Executes a given ADB command with the specified arguments.
  ///
  /// Throws an exception if the command fails or an error occurs during execution.
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

  /// Pushes a file from the local device to the remote device.
  ///
  /// Args:
  ///   localPath: The path to the file on the local device.
  ///   remotePath: The destination path on the remote device.
  Future<ProcessResult> pushFile(String localPath, String remotePath) async {
    return await executeAdbCommand(['push', localPath, remotePath]);
  }

  /// Pulls a file from the remote device to the local device.
  ///
  /// Args:
  ///   remotePath: The path to the file on the remote device.
  ///   localPath: The destination path on the local device.
  Future<ProcessResult> pullFile(String remotePath, String localPath) async {
    return await executeAdbCommand(['pull', remotePath, localPath]);
  }

  /// Installs an APK file on the connected Android device.
  ///
  /// Args:
  ///   apkPath: The path to the APK file to install.
  Future<ProcessResult> installApk(String apkPath) async {
    return await executeAdbCommand(['install', apkPath]);
  }
}