import 'package:flutter/foundation.dart';
import 'package:rechavedetorneio/models/competidor_model.dart';

import 'batalha_model.dart';

class EtapaModel {
  EtapaModel({@required this.batalhas, @required this.numEtapa});

  int numEtapa = -1;

  final List<BatalhaModel> batalhas;

  List<CompetidorModel> getVencedoresDaEtapa() {
    print('Obtendo os vencedores ETAPA_MODEL GET VENCEDORES DA ETAPA');
    List<CompetidorModel> vencedores = [];

    for (BatalhaModel batalha in batalhas) {
      //#1 Descobrimos o vencedor
      final CompetidorModel vencedor = batalha.getWinner();
      vencedores.add(vencedor);
    }

    return vencedores;
  }
}
