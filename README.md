# awesome_flutter_template

This is a private template for myself, DaviD4Chirino, if you stumble upon this, i will try to explain why i use these packages.

## Getting Started

* press the green button to use as a template or clone the repository
* run `flutter pub get`
* run `flutter pub run build_runner build`

And then run on your device, you should see a simple counter using hooks

## Packages used

* Riverpod
* Hooks
* Layout
* Custom lint
* Flutter native splash
  * look at the `flutter_native_splash.yaml` to start modifying
* Flutter launcher icons
  *  look at the `flutter_launcher_icons.yaml` to start modifying
* Flex Color scheme
* l10n and itnl
  * look at the `l10n.yaml` to start modifying
* Shared preferences
* Flutter Svg

## Folder structure

This project uses a atomic approach, that means that every feature the app has is considered a module, and each module can have its atoms, molecules, organisms, pages, etc.
- lib
  - modules (every single separate thing the app has)
    - home
      - atoms (single things that are self contained, like a button)
      - molecules (2 or more atoms joined to make a third thing)
      - organisms (a collection of molecules, larger and interconnected)
      - pages (also known as screens, the widget for the user to interact with)
      - templates (a reusable organism/molecule to put things in specific places)

## Features

* Easy to change the app name, icons, id, splash screen, etc. Go to the [commands](#commands) section
* Dark and light mode courtesy of [Flex Color scheme](https://pub.dev/packages/flex_color_scheme)
* Localizations with [l10n](https://pub.dev/packages/l10n) and [intl](https://pub.dev/packages/intl)


### Providers

#### Translation

Simple provider that, on build, will check if the user has a language saved in the shared preferences, if not, it will try to use the system language, it it fails, it will use english as the default language.

The main function is called `translate(String code)` (if the code is not valid, or it not supported, it will use english), and it will change the language to the one specified in the parameter.

#### Theme

Simple provider that will change the theme based on the theme mode saved in the shared preferences, if not, it will use the system theme.

The main function is called `changeTheme(ThemeMode mode)`, and it will change the theme to the one specified in the parameter. It also has `setDark()` and `setLight()` functions to change the theme to dark and light mode respectively.


### Commands

This part is controlled by [rename](https://pub.dev/packages/rename) package
* To rename the app name, run `dart pub global run rename setAppName --value [newAppName]`
* To change the id of the app, run `dart pub global run rename setBundleId --value [newAppId]`

* To create the splash screen run `dart run flutter_native_splash:create --path=flutter_native_splash.yaml`

* To make the launcher icon run `dart run flutter_launcher_icons`

* And this is convenient to run the build command, run `dart run build_runner build`