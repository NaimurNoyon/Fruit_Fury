import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:fruit_fury/src/components/simple_button.dart';
import 'package:fruit_fury/src/game.dart';

class BackButton extends SimpleButton
    with HasGameReference<MainRouteGame> {
  BackButton({VoidCallback? onPressed})
      : super(
      Path()
        ..moveTo(22, 8)
        ..lineTo(10, 20)
        ..lineTo(22, 32)
        ..moveTo(12, 20)
        ..lineTo(34, 20),
      position: Vector2.all(10)
  ) {
    super.action = onPressed ?? () => game.router.pop();
  }
}