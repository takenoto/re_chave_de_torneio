import 'package:flutter/material.dart';
import 'competidor_model.dart';

//Status da batalha
enum BattleStatus { none, finished }

class BatalhaModel {
  BatalhaModel(
      {@required this.competidor1,
      @required this.competidor2,
      @required this.etapaDaBatalha,
      @required this.numDaBatalha});
  final CompetidorModel competidor1, competidor2;

  final int etapaDaBatalha; //diz se a batalha ocorre na etapa 1, 2, etc
  final int numDaBatalha; //diz se a batalha é a 1ª, segunda, etc
  int competidorVencedor = -1; //inicialmente nenhum, também serve para debugar

  //Inicialmente não há vencedor...
  var status = BattleStatus.none;
  CompetidorModel _winner = CompetidorModel(useDefaultCompetidor: true);

  void setWinner({@required competidorVencedor}) {
    //Determina que a batalha se encerrou e acerta o competidor vitorioso
    //O int competidorVencedor atua como se fosse a ide do vencedor dentro da batalha, podendo ser 1 ou 2
    if (competidorVencedor == 1 || competidorVencedor == 2) {
      this.status = BattleStatus.finished;
      competidorVencedor == 1
          ? this._winner = competidor1
          : this._winner = competidor2;
    } else {
      print(
          'NÚMERO INFORMADO INVÁLIDO, TENTE 1 PARA COMPETIDOR 1 E 2 PARA COMPETIDOR 2');
    }
  }

  CompetidorModel getWinner() => _winner;

  bool winnerIsOne() {
    if (_winner == competidor1) {
      return true;
    } else
      return false;
  }

  bool battleFinished() => status == BattleStatus.finished ? true : false;
}
