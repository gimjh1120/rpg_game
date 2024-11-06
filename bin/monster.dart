import 'character.dart';
import 'dart:math';

class Monsters {
  String name;
  int health;
  int attackDamage;
  int armor;

  Monsters({
    required this.name,
    required this.health,
    required this.attackDamage,
    required this.armor,
  });

  void attackCharacter(Characters character) {
    if (!character.armorDefend) {
      int damage = max(0, attackDamage - character.armor);
      character.health = max(0, character.health - damage);
      print('${character.name}이(가) $name에게 $damage의 피해를 입었습니다.');
    }
  }

  void showStatus() {
    print('$name 상태 - 체력: $health | 공격력: $attackDamage');
  }
}