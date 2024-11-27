import 'package:flame/components.dart';

import '../go_green_game.dart';

class Trash extends SpriteComponent with HasGameRef<GoGreenGame>{
  Trash({required this.spritePath});
  final String spritePath;

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(spritePath);
    size = Vector2.all(300);
    // position = Vector2(0, 0);
    anchor = Anchor.center;
  }
}

class Trash0 extends Trash{
  Trash0() : super(spritePath: "trash.png");
}

class Trash1 extends Trash{
  Trash1() : super(spritePath: "trash.png");
}

class Trash2 extends Trash{
  Trash2() : super(spritePath: "trash.png");
}