import 'dart:io';
import 'dart:math';
import 'character.dart';
import 'monster.dart';

class Game {
  Characters character;
  List<Monsters> monsters;
  int killedMonster = 0;

  Game({
    required this.character,
    required this.monsters,
  });

  factory Game.fromFiles(String characterFile, String monsterFile) {
    Characters character;
    List<Monsters> monsters = [];

    try {
      File characFile = File(characterFile);
      if (!characFile.existsSync()) {
        throw FileSystemException('캐릭터 파일을 찾을 수 없습니다.');
      }

      List<String> characData = characFile.readAsLinesSync();
      if (characData.isEmpty) {
        throw FileSystemException('캐릭터 파일 데이터가 없습니다.');
      }

      List<int> characStatus = characData[0].split(',').map(int.parse).toList();
      if (characStatus.length != 3) {
        throw FormatException('캐릭터 파일 데이터 형식이 잘못되었습니다.');
      }

      String characterName = '';
      while (characterName.isEmpty ||
          !RegExp(r'^[a-zA-Z가-힣]+$').hasMatch(characterName)) {
        stdout.write('캐릭터 이름을 입력해주세요 (한글, 영문 대소문자만 가능): ');
        characterName = stdin.readLineSync() ?? '';
        if (characterName.isEmpty ||
            !RegExp(r'^[a-zA-Z가-힣]+$').hasMatch(characterName)) {
          print('잘못된 이름입니다. 한글과 영문 대소문자만 입력 가능합니다.');
        }
      }

      character = Characters(
        name: characterName,
        health: characStatus[0],
        attackDamage: characStatus[1],
        armor: characStatus[2],
      );

      File monFile = File(monsterFile);
      if (!monFile.existsSync()) {
        throw FileSystemException('몬스터 파일을 찾을 수 없습니다.');
      }

      List<String> monsterData = monFile.readAsLinesSync();
      if (monsterData.isEmpty) {
        throw FormatException('몬스터 파일 데이터가 없습니다.');
      }

      monsters = monsterData.map((line) {
        var parts = line.split(',');
        if (parts.length != 3) {
          throw FormatException('몬스터 파일 데이터 형식이 잘못되었습니다.');
        }
        return Monsters(
          name: parts[0],
          health: int.parse(parts[1]),
          attackDamage: int.parse(parts[2]),
          armor: 0,
        );
      }).toList();

      return Game(character: character, monsters: monsters);
    } catch (e) {
      print('데이터 로드 중 오류 발생: $e');
      rethrow;
    }
  }

  Monsters getRandomMonster() {
    // 몬스터 리스트에서 랜덤으로 몬스터를 선택하여 반환
    return monsters[Random().nextInt(monsters.length)];
  }

  void gameStart() {
    print('게임을 시작합니다.');
    while (character.health > 0 && killedMonster < monsters.length) {
      Monsters fightMonster = getRandomMonster();
      print('${character.name}이(가) ${fightMonster.name}과 전투를 시작합니다.');
      battle(fightMonster);

      if (character.health <= 0) {
        print('${character.name}이(가) 체력이 0이 되어 패배했습니다.');
        print('게임을 저장하시겠습니까?(y/n)');
        String? action = stdin.readLineSync();
        if (action != null && (action == 'y' || action == 'Y')) {
          saveResult('패배');
        }
        return;
      }
      killedMonster++;
      print(
          '${character.name} - 체력: ${character.health} | 공격력: ${character.attackDamage} | 방어력: ${character.armor}');
      if (killedMonster < monsters.length) {
        print('다음 몬스터와 대결하시겠습니까?(y/n)');
        String? choice = stdin.readLineSync();
        if (choice == null || (choice != 'y' && choice != 'Y')) {
          print('게임이 종료됩니다.');
          saveResult('패배');
          return;
        }
      }
    }
    print('모든 몬스터를 물리쳤습니다! ${character.name}이 게임에서 승리했습니다.');
    print('게임을 저장하시겠습니까?(y/n)');
    String? action = stdin.readLineSync();
    if (action != null && (action == 'y' || action == 'Y')) {
      saveResult('승리');
    }
  }

  void battle(Monsters monster) {
    while (character.health > 0 && monster.health > 0) {
      character.showStatus();
      monster.showStatus();

      print('행동을 선택하세요 (1: 공격하기, 2: 방어하기)');
      String? action = stdin.readLineSync();
      if (action == '1') {
        character.attackMonster(monster);
        character.armorDefend = false;
      } else if (action == '2') {
        character.defend(monster);
      } else {
        print('잘못된 입력입니다. 다시 입력해주세요.');
        continue;
      }

      if (monster.health > 0 && character.armorDefend == false) {
        monster.attackCharacter(character);
      }

      if (character.health <= 0) {
        print('${character.name}이(가) 쓰러졌습니다.');
        return;
      }
    }
  }

  void saveResult(String result) {
    File resultFile = File('result.txt');
    resultFile.writeAsStringSync(
        '이름: ${character.name}, 체력: ${character.health}, 공격력: ${character.attackDamage}, 방어력: ${character.armor}, 몬스터 킬 수: $killedMonster, 결과: $result');
    print('게임 결과를 저장했습니다.');
  }
}
