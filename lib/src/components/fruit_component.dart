import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/image_composition.dart' as composition;
import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../config/utils.dart';
import '../models/fruit_model.dart';
import '../routes/game_page.dart';

class FruitComponent extends SpriteComponent {
  Vector2 velocity;
  final Vector2 pageSize;
  final double acceleration;
  final FruitModel fruit;
  final composition.Image image;
  late Vector2 _initPosition;
  bool _canDragOnShape = false;
  GamePage parentComponent;
  bool divided;

  FruitComponent(this.parentComponent,
      Vector2 p, {
        Vector2? size,
        required this.velocity,
        required this.acceleration,
        required this.pageSize,
        required this.image,
        required this.fruit,
        double? angle,
        Anchor? anchor,
        this.divided = false
      }) : super(
    sprite: Sprite(image),
    position: p,
    size: size,
    anchor: anchor ?? Anchor.center,
    angle: angle,
  ){
    _initPosition = p;
    _canDragOnShape = false;
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);

    angle += .5 * dt;
    angle %= 2 * pi;

    position += Vector2(0, -(velocity.y * dt - .5 * AppConfig.gravity * dt * dt));

    velocity.y += (AppConfig.acceleration + AppConfig.gravity) * dt;

    if((position.y - AppConfig.objSize) > pageSize.y){
      removeFromParent();
    }

  }

  void touchAtPoint(Vector2 vector2){
    // angleOfTouchPoint
    final a = Utils.getAngleOfTouchPoint(
        center: position,
        initAngle: angle,
        touch: vector2
    );

    if(a < 45 || (a > 135 && a < 225) || a > 315){
      findGame()?.addAll([
        RectangleComponent(
            size: Vector2(size.x, size.y / 2),
            position: center -
                Vector2(size.x / 2 * cos(angle), size.x / 2 * sin(angle)),
            angle:  angle,
            anchor: Anchor.topLeft,
            paint: Paint()..color = Colors.red
        ),
        RectangleComponent(
            size: Vector2(size.x, size.y / 2),
            position: center +
                Vector2(size.x / 4 * cos(angle + 3 * pi / 2),
                    size.x / 4 *  sin(angle + 3 * pi / 2)),
            angle:  angle,
            anchor: Anchor.center,
            paint: Paint()..color = Colors.blue
        )
      ]);
    }else{
      findGame()?.addAll([
        RectangleComponent(
            size: Vector2(size.x / 2, size.y),
            position: center -
                Vector2(size.x / 4 * cos(angle), size.x / 4 * sin(angle)),
            angle:  angle,
            anchor: Anchor.center,
            paint: Paint()..color = Colors.red
        ),
        RectangleComponent(
            size: Vector2(size.x / 2, size.y),
            position: center +
                Vector2(size.x / 2 * cos(angle + 3 * pi / 2),
                    size.x / 2 * sin(angle + 3 * pi / 2)),
            angle:  angle,
            anchor: Anchor.topLeft,
            paint: Paint()..color = Colors.blue
        )
      ]);
    }

    removeFromParent();
  }

}