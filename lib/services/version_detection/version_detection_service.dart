import 'package:doya/tokens/utils/modules/local_storage/local_storage.dart';
import 'package:doya/tokens/utils/modules/local_storage/models/local_storage_paths.dart';
import 'package:doya/tokens/utils/utils.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract class VersionDetectionService {
  static int currentVersion = 0;
  static int previousVersion = 0;

  static Future<void> getVersion({
    required Future<void> Function(
      int? previousVersion,
      int currentVersion,
    )
    onNewVersionInstalled,
  }) async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final version = packageInfo.version;

      currentVersion = Utils.versionStringToInt(version);

      final int? prevVersion = LocalStorage.getInt(
        LocalStoragePaths.previousVersion,
      );

      if (prevVersion == null) {
        Utils.log(
          "Previous version key does not exist, running callback as a new update",
        );

        await LocalStorage.setInt(
          LocalStoragePaths.previousVersion,
          currentVersion,
        );
        previousVersion = prevVersion ?? 0;
        await onNewVersionInstalled(prevVersion, currentVersion);
        return;
      }

      if (currentVersion > prevVersion) {
        Utils.log(
          "Current version is newer than the previous version, running callback",
        );

        await onNewVersionInstalled(prevVersion, currentVersion);
        await LocalStorage.setInt(
          LocalStoragePaths.previousVersion,
          currentVersion,
        );
        return;
      }

      Utils.log(
        "Current Version is older or equal than the old version, doing nothing",
      );
    } on Exception catch (_) {
      Utils.log("Error running the version detection, stopping");
      rethrow;
    }

    // version = await deviceInfo.version;
  }
}
