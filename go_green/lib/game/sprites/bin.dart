import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:go_green/game/sprites/player.dart';import '../../constants.dart';


import '../go_green_game.dart';

class Bin extends SpriteComponent with HasGameRef<GoGreenGame>, CollisionCallbacks{
  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprite = await Sprite.load("bin.png");
    size = Vector2.all(300);
    position = Vector2(0,(gameHeight/2 - size.y /2));
    anchor = Anchor.center;
    add(RectangleHitbox());
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player && other.position.y > position.y){
      other.removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}