import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_green/constants.dart';
import 'package:go_green/game/go_green_game.dart';

class MyGame extends StatefulWidget{
  const MyGame({super.key});

  @override
  State<MyGame> createState() => MyGameState();
}

class MyGameState extends State<MyGame> {
  late final GoGreenGame game;

  @override
  void initState() {
    super.initState();
    game = GoGreenGame();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.yellow
      ),
      home: Scaffold(
        body: SafeArea(
            child: Center(
              child: FittedBox(
                child: SizedBox(
                  width: gameWidth,
                  height: gameHeight,
                  child: GameWidget(game: game),
                ),
              ),
            )
        ),
      ),
    );
  }
}