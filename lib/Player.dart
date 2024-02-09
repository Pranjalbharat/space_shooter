
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:space_shooter/Bullet.dart';
import 'package:space_shooter/enemy.dart';
import 'package:space_shooter/main.dart';
import 'dart:async';


class Player extends SpriteAnimationComponent with HasGameReference<SpaceShooterGame> {
  // static final _paint=Paint()..color=Colors.red;
  

  Player(): super(
  anchor: Anchor.center,
  size:Vector2(100,150),);

  late final SpawnComponent _bulletSpawner;
 

  @override
  Future<void> onLoad() async{
    await super.onLoad();

      _bulletSpawner = SpawnComponent(
      period: .2,
      selfPositioning: true,
      factory: (index) {
        return Bullet(
          position: position +
              Vector2(
                0,
                (-height / 2),
              ),
        );

      },
      autoStart: false,
    );

    game.add(_bulletSpawner);

    animation = await game.loadSpriteAnimation(
      'player.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2(32,48))
    );
    // sprite = await gameRef.loadSprite('player-sprite.png');
    position=game.size/2;

 

    // add(
    //   SpawnComponent(factory: (index){
    //     return Enemy();
    //   },
    //   period: 1,
    //   area: Rectangle.fromLTWH(0,0,size.x,-Enemy.enemySize),)
    // );
  }
  
  // @override
  // void render(Canvas canvas){
  //   canvas.drawRect(size.toRect(),_paint);
  // }

  void move(Vector2 delta){
    position.add(delta);
  }

  void startShooting(){
_bulletSpawner.timer.start();
  }

  void stopShooting(){
_bulletSpawner.timer.stop();
  }
}