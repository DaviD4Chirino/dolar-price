import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:doya/tokens/models/update_data.dart';
import 'package:doya/tokens/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract class GithubAutoUpdater {
  static final url =
      "https://api.github.com/repos/DaviD4Chirino/dolar-price/releases/latest";

  static Future<UpdateData?> checkForUpdatesAndroid() async {
    final latestRelease = await getLatestRelease();
    final androidSupportedAbis = await getSupportedAbis();

    final packageInfo = await PackageInfo.fromPlatform();
    final appVersion = Utils.versionStringToInt(
      packageInfo.version,
    );
    final remoteVersion = Utils.versionStringToInt(
      latestRelease["tag_name"] as String,
    );

    if (appVersion > remoteVersion) {
      Utils.log("Already up to date");
      return null;
    }

    final assets = latestRelease["assets"] as List<dynamic>;

    String? downloadUrl;

    outerLoop:
    for (final asset in assets) {
      final fileName = asset["name"] as String;
      if (!fileName.endsWith(".apk")) continue;
      //NOTE: The name schema is: {name}_{abi}_v{version}.apk
      //So it would be doya_arm64_v1.0.0.apk
      if (fileName.contains("universal")) {
        downloadUrl = asset["browser_download_url"] as String;
      }

      for (final abi in androidSupportedAbis) {
        if (fileName.endsWith("$abi-release.apk")) {
          downloadUrl = asset["browser_download_url"] as String;
          break outerLoop;
        }
      }
    }
    Utils.log(downloadUrl);
    if (downloadUrl == null) {
      Utils.log("Could not find apk for this device");
    }

    return UpdateData(
      body: latestRelease["body"] as String,
      pageUrl: latestRelease["html_url"] as String,
      version: remoteVersion,
      downloadUrl: downloadUrl ?? "",
      releaseDateUnix: DateTime.parse(
        latestRelease["published_at"] as String,
      ).millisecondsSinceEpoch,
    );
  }

  static Future<Map<String, dynamic>> getLatestRelease() async {
    final dio = Dio();
    try {
      final httpPackageUrl = await dio.get(url);
      return httpPackageUrl.data as Map<String, dynamic>;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception("Could not get latest release");
    }
  }

  static Future<List<String>> getSupportedAbis() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.supportedAbis;
  }
}

class GhReleaseData {
  final String name;
  final String body;
  final String tagName;
  final String htmlUrl;
  final String downloadUrl;
  final int version;

  GhReleaseData({
    required this.name,
    required this.body,
    required this.tagName,
    required this.version,
    required this.htmlUrl,
    required this.downloadUrl,
  });
}
