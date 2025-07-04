
// 캐릭터의 체력이 0 이하가 되면 게임이 종료됩니다.
import 'dart:io';
import 'dart:math';

class Character{
String name;
int health ;
int attack ;
int defense ;

Character(this.name,this.health,this.attack,this.defense);

// 1.3 용사 정보를 불러오고 showStatus를 출력
void CharacterStatus() {
  print("용사의 이름은 $name , 체력: $health, 공격력: $attack, 방어력: $defense ");
} 

// 3.1 용사가 몬스터를 공격력 만큼 데미지를 입힌다.
// 3.2 몬스터의 방어력 만큼 차감해서 체력에 피해를 줌
// 3.3 최소 데미지는 0 이상 

void attackMonster(Monster monster){
  int damage = attack - monster.defense;

  if (damage < 0) {
    damage = 0;
    print("몬스터가 너무 강력합니다.");
    print("$name이(가) 몬스터에게 $damage 만큼 피해를 입혔습니다.");
  }
  // 3.4 피해를 입은 만큼 몬스터의 체력이 차감됨
  // 3.5 몬스터의 남은 체력
  int lasthealth = monster.health - damage;
}

}

//1.1 사용자가 용사 이름을 입력한다.
//1.2 메모장에 있는 용사정보를 불러온다.
Character loadCharacterStats() {
  try {
    print("용사의 이름을 입력하세요.");
    String? name = stdin.readLineSync() ?? "";
    if (name.isEmpty) {
      print("용사의 이름을 다시 입력해주세요.");
      exit(1);
    }

    final file = File('lib/character.txt');
    final contents = file.readAsStringSync();
    final stats = contents.split(',');
    if (stats.length != 3) throw FormatException('Invalid character data');

    int health = int.parse(stats[0]);
    int attack = int.parse(stats[1]);
    int defense = int.parse(stats[2]);

    Character character = Character(name, health, attack, defense);
    return character;

  } catch (e) {
    print('캐릭터 데이터를 불러오는 데 실패했습니다: $e');
    exit(1);
  }
}

class Monster {
  String name ;
  int health ;
  int attack;
  int defense = 0;

  Monster (this.name, this.health, this.attack); 

  void attachCharater(Character character){}
  void showStatus(){
    print(" $name - 체력: $health, 공격력: $attack, 방어력: $defense ");
  } 
}
/*
void loadMonsterStats() {

//2.1 메모장에 있는 몬스터정보를 불러온다.
  try {

    final file = File('lib/monsters.txt');
    final contents = file.readAsStringSync(); // 한줄씩 변환
    List<Monster> monsterlist =[];
    final stats = contents.split('\n'); // 변환한 각각의 데이터 사이에 "," 삽입

    if (stats.length != 3) throw FormatException('Invalid character data');
  
    String name = (stats[0]);
    int health = int.parse(stats[1]);
    int attack = int.parse(stats[2]);

    
    monsterlist.add(Monster(name,health,attack));
  
    print("$monsterlist");
    //

  } catch (e) {
    print('몬스터 데이터를 불러오는 데 실패했습니다: $e');
    exit(1);
  }
}
*/

//2.1 monsters.txt를 Monster 클래스 생성자로 만듬
List<Monster> loadMonsterStats() {
  try {
    final file = File('lib/monsters.txt');
    final contents = file.readAsStringSync();

    List<Monster> monsterlist = [];
    final lines = contents.split('\n');

    for (var line in lines) { // monsters.txt에서 한줄씩 읽어나감
      if (line.trim().isEmpty) continue;
      final stats = line.split(',');

      if (stats.length != 3) throw FormatException('Invalid monster data: $line');

      String name = stats[0].trim();
      int health = int.parse(stats[1].trim());
      int attack = int.parse(stats[2].trim());

      monsterlist.add(Monster(name, health, attack));
    }

    return monsterlist; 

  } catch (e) {
    print('몬스터 데이터를 불러오는 데 실패했습니다: $e');
    exit(1);
  }
}

// 2.2 불러온 몬스터 리스트의 행 값을 랜덤으로 선택 - AI
Monster getRandomMonster(List<Monster> monsters) {
  final random = Random();
  return monsters[random.nextInt(monsters.length)];
}

class Game {
  
}


void main(){
  
print("게임을 시작합시다.");
Character character = loadCharacterStats();
character.CharacterStatus;

print("앗! 불량한 몬스터가 나타났다!!!!!!");
//2.3 랜덤으로 선택한 몬스터를 출력

List<Monster> callmonsters = loadMonsterStats();
  Monster selected = getRandomMonster(callmonsters);
  selected.showStatus(); 


}