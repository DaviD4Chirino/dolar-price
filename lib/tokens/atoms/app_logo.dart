import 'package:awesome_dolar_price/tokens/app/app_sizing.dart';
import 'package:awesome_dolar_price/tokens/mixins/consumer_mixin.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum LogoType { icon, branding, title, titleWithSlogan }

class AppLogo extends ConsumerStatefulWidget {
  const AppLogo({
    super.key,
    this.width,
    this.height,
    this.type = LogoType.icon,
  });

  final double? width;
  final double? height;
  final LogoType type;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AppLogoState();

  const AppLogo.square({
    super.key,
    required double size,
    this.type = LogoType.icon,
  }) : width = size,
       height = size;
}

class _AppLogoState extends ConsumerState<AppLogo>
    with ConsumerMixin {
  @override
  Widget build(BuildContext context) {
    var width = widget.width ?? AppSizing.xxxl;
    var height = widget.height ?? AppSizing.xxl;

    switch (widget.type) {
      case LogoType.icon:
        return _buildIcon(width, height);
      case LogoType.branding:
        return _buildBranding(width, height);
      case LogoType.title:
        return _buildTitle(width, height);
      case LogoType.titleWithSlogan:
        return _buildTitleWithSlogan(width, height);
    }
  }

  Widget _buildIcon(double width, double height) {
    return Image.asset(
      "assets/icons/logo/logo.png",
      width: width,
      height: height,
    );
  }

  Widget _buildBranding(double width, double height) {
    return Image.asset(
      "assets/icons/logo/logo-branding${isLightMode(ref) ? "" : "-dark"}.png",
      width: width,
      height: height,
    );
  }

  Widget _buildTitle(double width, double height) {
    return Image.asset(
      "assets/icons/logo/logo-title.png",
      width: width,
      height: height,
    );
  }

  Widget _buildTitleWithSlogan(double width, double height) {
    return Image.asset(
      "assets/icons/logo/logo-title-with-slogan${isLightMode(ref) ? "" : "-dark"}.png",
      width: width,
      height: height,
    );
  }
}
