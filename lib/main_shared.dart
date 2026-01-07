import 'package:doya/services/version_detection/version_detection_service.dart';
import 'package:doya/tokens/utils/modules/local_storage/local_storage.dart';
import 'package:doya/tokens/utils/modules/local_storage/models/local_storage_paths.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class MainShared {
  static Future<List<void>> initializations() async {
    await LocalStorage.init();

    return Future.wait<void>([
      dotenv.load(),
      VersionDetectionService.getVersion(
        onNewVersionInstalled: clearKeys,
      ),
    ]);
  }
}

Future<void> clearKeys(int? oldVersion, int newVersion) async {
  await LocalStorage.remove(LocalStoragePaths.mainCurrency);
  await LocalStorage.remove(LocalStoragePaths.currencyQuotes);
}
