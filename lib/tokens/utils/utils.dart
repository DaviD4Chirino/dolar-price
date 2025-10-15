import 'package:flutter/foundation.dart';

abstract class Utils {
  /// Logs the given [message] to the console.
  static void log([
    Object? message,
    Object? message2,
    Object? message3,
    Object? message4,
    Object? message5,
  ]) {
    if (kDebugMode) {
      if (message != null) print(message);
      if (message2 != null) print(message2);
      if (message3 != null) print(message3);
      if (message4 != null) print(message4);
      if (message5 != null) print(message5);
    }
  }

  static int versionStringToInt(String versionString) {
    // Remove the 'v' prefix if present
    String version = versionString.startsWith('v')
        ? versionString.substring(1)
        : versionString;

    // Split the version into its components
    List<String> components = version.split('.');

    // Ensure the version has major, minor, and patch components
    if (components.length != 3) {
      throw FormatException(
        'Invalid semantic versioning format',
      );
    }

    int major = int.parse(components[0]);
    int minor = int.parse(components[1]);
    int patch = int.parse(components[2]);

    // Combine the components into a single integer
    // Example: v0.5.0 -> 005000 (assuming major, minor, patch are 2 digits each)
    return major * 1000000 + minor * 1000 + patch;
  }

  static String versionIntToString(int versionInt) {
    // Split the version into its components
    List<int> components = [];
    components.add(versionInt ~/ 1000000);
    components.add((versionInt % 1000000) ~/ 1000);
    components.add(versionInt % 1000);

    // Ensure the version has major, minor, and patch components
    if (components.length != 3) {
      throw FormatException(
        'Invalid semantic versioning format',
      );
    }

    // Convert the components back into a string
    // Example: 005000 -> v0.5.0
    return 'v${components[0]}.${components[1]}.${components[2]}';
  }
}
