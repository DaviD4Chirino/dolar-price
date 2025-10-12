import 'package:doya/tokens/utils/modules/local_storage/local_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class MainShared {
  static Future<List<void>> initializations() async {
    return Future.wait<void>([
      LocalStorage.init(),
      dotenv.load(),
    ]);
  }
}
