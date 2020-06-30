import 'package:flutter/foundation.dart';
import 'package:rechavedetorneio/models/competidor_model.dart';

import 'etapa_model.dart';

class ChaveDeTorneioModel {
  //Inicializa com as etapas!
  ChaveDeTorneioModel({@required List<EtapaModel> etapas}) {
    this.etapas = etapas;
  }

  List<CompetidorModel> competidores = [];
  //Contém TODOS os competidores, serão separados posteriormente

  List<EtapaModel> etapas = [];
  //Separa os competidores por etapa:
  //primeiramente, descobrir o número de etapas:
  int numeroDeEtapas;

  //Recebe a etapa e o número da batalha, e determina o vencedor usando o competidor passado!
  //Por padrão iremos determinar aleatoriamente
  setWinner(
      {@required int numEtapa,
      @required int numBatalha,
      @required int numVencedor}) {
    etapas[numEtapa]
        .batalhas[numBatalha]
        .setWinner(competidorVencedor: numVencedor);
  }
}
