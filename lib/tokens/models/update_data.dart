import 'package:doya/tokens/utils/utils.dart';

class UpdateData {
  final int version;
  final int releaseDateUnix;
  final String downloadUrl;
  final String pageUrl;
  final String body;

  String get versionString => Utils.versionIntToString(version);

  UpdateData({
    required this.version,
    required this.downloadUrl,
    required this.pageUrl,
    required this.body,
    required this.releaseDateUnix,
  });
}
