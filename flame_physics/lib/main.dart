import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GameWidget(game: MyGame())
  );
}

class MyGame extends Forge2DGame{
  MyGame(): super(gravity: Vector2(0, 9.8));
  @override
  Future<dynamic> onLoad() async {
    await super.onLoad();
    Vector2 gameSize = size;
    add(Ground(gameSize));
    add(Player());
  }
}

class Player extends BodyComponent{
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;

    add(
        SpriteComponent(
          sprite: await game.loadSprite('mash.png'),
          size: Vector2.all(100),
          anchor: Anchor.center
        )
    );
  }
  @override
  Body createBody() {
    final shape = CircleShape()..radius = 60;
    final fixtureDef = FixtureDef(shape, density: 1.0, restitution: 0.8, friction: 0.5);
    final bodyDef = BodyDef(position: Vector2(150,0), type: BodyType.dynamic);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class Ground extends BodyComponent{
  final Vector2 gameSize;
  Ground(this.gameSize);

  @override
  Body createBody() {
    final shape = EdgeShape()..set(Vector2(0, gameSize.y-30), Vector2(gameSize.x, gameSize.y-30));
    final fixtureDef = FixtureDef(shape, friction: 0.3);
    final bodyDef = BodyDef(userData: this, position: Vector2.zero());
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}