import 'dart:io';
import 'game_class.dart';

void loadGame() {
  File resultFile = File('result.txt');
  if (resultFile.existsSync()) {
    List<String> resultData = resultFile.readAsLinesSync();
    for (var line in resultData) {
      print(line);
    }
  } else {
    print('저장된 게임 결과가 없습니다.');
  }
}

void main() {
  print('콘솔 RPG 게임을 시작합니다!');
  try {
    String characterFile = 'characters.txt';
    String monsterFile = 'monsters.txt';
    Game game = Game.fromFiles(characterFile, monsterFile);
    game.gameStart();

    print('게임 정보를 불러오려면 Enter 키를 누르세요.');
    stdin.readLineSync();
    loadGame();
  } catch (e) {
    print('게임을 시작하는 중 오류가 발생했습니다: $e');
  }
}
