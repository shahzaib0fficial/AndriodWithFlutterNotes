import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:go_green/constants.dart';
import 'package:go_green/game/go_green_game.dart';

class Player extends SpriteComponent with HasGameRef<GoGreenGame>{

  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprite = await Sprite.load("bottle.png");
    size = Vector2.all(100);
    position = Vector2(0,-(gameHeight/2) + (size.y/2));
    anchor = Anchor.center;
    add(RectangleHitbox());
  }


  @override
  void update(double dt){
    super.update(dt);

    double newY = position.y + (dt*400);

    if (newY > (gameRef.size.y / 2) - (size.y/2)){
      newY = (gameRef.size.y / 2) - (size.y/2);
    }

    position.y = newY;
  }

  void moveX(deltaX){
    double newX = position.x + deltaX;

    double minX = -(gameRef.size.x / 2) + (size.x / 2);
    double maxX = (gameRef.size.x / 2) - (size.x / 2);

    newX = newX.clamp(minX, maxX);

    position.x = newX;
  }
}