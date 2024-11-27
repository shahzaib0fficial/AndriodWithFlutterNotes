import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_green/constants.dart';
import 'package:go_green/game/go_green_world.dart';

class GoGreenGame extends FlameGame<GoGreenWorld> with HorizontalDragDetector, HasCollisionDetection{
  GoGreenGame(): super(
    world: GoGreenWorld(),
    camera: CameraComponent.withFixedResolution(width: gameWidth, height: gameHeight)
  );
  // Setting Background Color
  @override
  Color backgroundColor() {
    return Colors.green;
  }

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    debugMode = true;
  }

  @override
  void onHorizontalDragUpdate(DragUpdateInfo info){
    super.onHorizontalDragUpdate(info);
    world.player.moveX(info.delta.global.x);
  }
}