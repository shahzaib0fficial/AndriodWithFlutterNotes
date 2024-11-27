import 'dart:async';

import 'package:flame/components.dart';
import 'package:go_green/game/go_green_game.dart';
import 'package:go_green/game/sprites/bin.dart';
import 'package:go_green/game/sprites/trash.dart';

import 'sprites/player.dart';

class GoGreenWorld extends World with HasGameRef<GoGreenGame>{
  late final Player player;
  late final Bin bin;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    player = Player();
    bin = Bin();

    add(player);
    add(bin);

    add(Trash0());
    add(Trash1()..position = Vector2(-336.0, 0));
    add(Trash2()..position = Vector2(336.0, 0));
  }

  @override
  void update(double dt){
    super.update(dt);

    children.whereType<Trash>().forEach((trash){
      trash.position.y -= (dt*400);

      if (trash.position.y < -(gameRef.size.y/2)){
        trash.position.y = gameRef.size.y;
      }
    }) ;
  }
}