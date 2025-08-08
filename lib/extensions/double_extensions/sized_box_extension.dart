import 'package:flutter/material.dart';

extension SizedBoxExtension on double {
  SizedBox get sizedBox => SizedBox(width: this, height: this);
  SizedBox get sizedBoxW => SizedBox(width: this);
  SizedBox get sizedBoxH => SizedBox(height: this);
}
