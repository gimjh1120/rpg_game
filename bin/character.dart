import 'monster.dart';
import 'dart:math';

class Characters {
  String name;
  int health;
  int attackDamage;
  int armor;
  bool armorDefend;

  Characters({
    required this.name,
    required this.health,
    required this.attackDamage,
    required this.armor,
    this.armorDefend = false,
  });

  void attackMonster(Monsters monster) {
    int damagePercent = Random().nextInt(20) + 100;
    int damage = (attackDamage * (damagePercent / 100)).round();
    damage = max(0, damage - monster.armor);
    monster.health = max(0, monster.health - damage);
    print('$name이(가) ${monster.name}에게 $damage의 데미지를 입혔습니다.');
  }

  void defend(Monsters monster) {
    int reflect = Random().nextInt(101);
    if (reflect <= 30) {
      int reflectPercent = Random().nextInt(20) + 20;
      int reflectDamage =
          (monster.attackDamage * (reflectPercent / 100)).round();
      monster.health = max(0, monster.health - reflectDamage);
      print('$name이(가) 방어에 성공하여 ${monster.name}에게 $reflectDamage의 데미지를 입혔습니다.');
      armorDefend = true;
    } else {
      print('$name이(가) 방어에 실패했습니다.');
      armorDefend = false;
      //monster.attackCharacter(this);
    }
  }

  void showStatus() {
    print('$name 상태 - 체력: $health | 공격력: $attackDamage | 방어력: $armor');
  }
}
