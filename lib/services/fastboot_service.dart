import 'dart:io';


class FastbootService {
  Future<ProcessResult> executeFastbootCommand(List<String> arguments) async {
    try {
      final result = await Process.run('fastboot', arguments);
      if (result.exitCode != 0) {
        throw Exception('Fastboot command failed: ${result.stderr}');
      }
      return result;
    } catch (e) {
      throw Exception('Error executing Fastboot command: $e');
    }
  }

  Future<ProcessResult> flashFile(String filePath) async {
    return await executeFastbootCommand(['flash', 'all', filePath]);
  }
}