import 'package:awesome_dolar_price/tokens/app/app_sizing.dart';
import 'package:awesome_dolar_price/tokens/mixins/consumer_mixin.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppLogo extends ConsumerStatefulWidget {
  const AppLogo({
    super.key,
    this.width,
    this.height,
    this.extended = false,
  });

  final double? width;
  final double? height;

  final bool extended;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppLogoState();

  const AppLogo.square({super.key, required double size, this.extended = false})
      : width = size,
        height = size;
}

class _AppLogoState extends ConsumerState<AppLogo> with ConsumerMixin {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      widget.extended
          ? "assets/icons/logo/logo-extended${isLightMode(ref) ? "" : "-dark"}.png"
          : "assets/icons/logo/${isLightMode(ref) ? "logo" : "logo-dark"}.png",
      width: widget.width ?? AppSizing.xxxl,
      height: widget.height ?? AppSizing.xxl,
    );
  }
}
