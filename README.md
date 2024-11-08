# Console RPG Game in Dart

이 프로젝트는 다트(Dart) 언어로 구현된 콘솔 기반 RPG 게임입니다. 플레이어는 다양한 몬스터와 전투를 통해 게임을 진행하며, 체력, 공격력, 방어력 등의 속성을 사용하여 전투를 수행합니다. 게임 진행 중 발생한 결과는 파일에 저장됩니다.

## Features

-   **캐릭터와 몬스터 데이터 관리**: 외부 파일에서 데이터를 불러와 캐릭터와 몬스터의 정보를 초기화합니다.
-   **전투 시스템**: 캐릭터와 몬스터 간의 전투를 관리하며, 공격과 방어 기능을 포함합니다.
-   **상태 출력 및 저장**: 전투 중 캐릭터와 몬스터의 상태를 출력하고, 게임 종료 시 결과를 저장할 수 있습니다.
-   **랜덤 요소**: 공격력과 반격 데미지가 랜덤으로 계산되어 전투의 변동성을 높입니다.

## 프로젝트 구조

-   **`main.dart`**: 게임의 진입점이며, 전반적인 게임 흐름을 제어합니다.
-   **`Characters` 클래스**: 플레이어 캐릭터의 속성과 행동(공격, 방어) 메서드를 포함합니다.
-   **`Monsters` 클래스**: 몬스터의 속성과 행동 메서드를 포함합니다.
-   **`Game` 클래스**: 전투 진행 및 게임 시작, 저장 로직을 관리합니다.

## Requirements

-   Dart SDK 설치가 필요합니다.
-   `characters.txt`, `monsters.txt` 파일이 프로젝트 폴더에 위치해야 합니다.

## Installation & Execution

1. **프로젝트 다운로드**: 이 프로젝트를 클론하거나 직접 다운로드합니다.

    ```bash
    git clone https://github.com/gimjh1120/rpg_game
    cd console-rpg-dart
    ```

2. **Dart 실행**: Dart SDK가 설치되어 있는지 확인합니다.

3. **필수 파일 추가**: 프로젝트 폴더에 `characters.txt`, `monsters.txt`, `result.txt` 파일을 추가합니다.

    - **`characters.txt`** 예제:
        ```
        100,20,10
        ```
    - **`monsters.txt`** 예제:
        ```
        Goblin,50,15,5
        Dragon,200,35,10
        ```

4. **게임 실행**:

    ```bash
    dart main.dart
    ```

5. **게임 저장된 결과 확인**: `result.txt` 파일에서 게임 결과를 확인할 수 있습니다.

## Game Mechanics

### 캐릭터 공격

-   캐릭터는 몬스터에게 공격하여 몬스터의 체력을 감소시킵니다.
-   **랜덤 공격력**: 100 ~ 120%의 랜덤 퍼센트가 적용되어 매 공격마다 공격력이 변동됩니다.

### 방어

-   캐릭터는 방어 기능을 통해 몬스터의 공격을 막을 수 있으며, 반격할 확률(30%)이 있습니다.
-   방어 성공 시 캐릭터는 체력을 일부 회복하며 몬스터에게 반격 피해를 입힙니다.

### 전투 종료

-   캐릭터가 몬스터를 모두 물리치거나, 캐릭터의 체력이 0 이하가 되면 게임이 종료됩니다.
-   게임 종료 시 결과를 `result.txt` 파일에 저장할 수 있습니다.

## Files

-   **`characters.txt`**: 캐릭터 초기 데이터를 정의하는 파일입니다.
    -   각 줄에 `체력,공격력,방어력` 형식으로 기재됩니다.
-   **`monsters.txt`**: 몬스터 초기 데이터를 정의하는 파일입니다.
    -   각 줄에 `이름,체력,공격력,방어력` 형식으로 기재됩니다.
-   **`result.txt`**: 게임 진행 결과가 저장되는 파일입니다. 캐릭터의 상태와 게임 종료 결과(승리/패배)가 포함됩니다.

## Troubleshooting

-   **데이터 파일이 누락된 경우**: `characters.txt`, `monsters.txt` 파일이 존재해야 합니다. 누락되었을 시 프로그램이 `FileNotFoundException`을 발생시킵니다.
-   **잘못된 입력 오류**: 입력된 데이터 형식이 올바르지 않을 경우 `FormatException`이 발생할 수 있습니다. 데이터 파일의 형식을 다시 확인해 주세요.
-   **게임 진행 중 무한 루프**: 캐릭터의 행동이 루프 내에서 의도대로 작동하지 않을 경우, `return` 문을 통해 루프를 빠져나올 수 있도록 코드를 확인해 보세요.

---

### Author

-   김재형
