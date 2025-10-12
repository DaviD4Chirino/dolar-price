enum AppFlavors {
  // Should never be none
  none,
  github,
  playstore,
}

abstract class AppFlavor {
  static bool alreadySet = false;
  static AppFlavors currentFlavor = AppFlavors.none;

  static bool get isGithub => currentFlavor == AppFlavors.github;
  static bool get isPlaystore =>
      currentFlavor == AppFlavors.playstore;
  static bool get isNone => currentFlavor == AppFlavors.none;

  static void setFlavor(AppFlavors flavor) {
    if (alreadySet) {
      throw Exception('Flavor already set');
    }
    currentFlavor = flavor;
    alreadySet = true;
    if (currentFlavor == AppFlavors.none) {
      throw Exception('Flavor cannot be none');
    }
  }
}
