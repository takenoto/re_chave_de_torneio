import 'package:rechavedetorneio/models/batalha_model.dart';
import 'package:rechavedetorneio/models/competidor_model.dart';

int numeroDeCompetidoresNoInicio = 8;
//int numeroDeCompetidoresNoInicio = 2 * 2 * 2 * 2 * 2 * 2 * 2 * 2;

class ChaveData {
  static List<BatalhaModel> getBatalhas() {
    print('Obtendo batalhas');
    //Lista de batalhas - viria de um database por exemplo. Isso é uma simulação!
    List<BatalhaModel> batalhas = [];

    int numeroDeBatalhasNaEtapa0 = (numeroDeCompetidoresNoInicio / 2).round();
    int batalhaAtual = 0;
    for (int i = 0; i < numeroDeBatalhasNaEtapa0 * 2; i += 2) {
      //Cria os respectivos competidores
      final CompetidorModel competidor1 = CompetidorModel(
          name: '#${i} Competidor', useDefaultCompetidor: false);
      final CompetidorModel competidor2 = CompetidorModel(
          name: '#${i + 1} Competidor', useDefaultCompetidor: false);

      //Cria a batalha com os competidores
      final BatalhaModel batalhaModel = BatalhaModel(
          competidor1: competidor1,
          competidor2: competidor2,
          etapaDaBatalha: 0,
          numDaBatalha: batalhaAtual);

      //Coloca um vencedor: Por padrão, sempre coloquei para o primeiro vencer em num ímpar o 2 em pares
      int numVencedor;
      batalhaAtual % 2 != 0 ? numVencedor = 1 : numVencedor = 2;
      batalhaModel.setWinner(competidorVencedor: numVencedor);

      //Adiciona a batalha à lista:
      batalhas.add(batalhaModel);

      //Incrementa  o contador de batalhas:
      batalhaAtual++;
    }

    print('Numero de batalhas na fase 0 = $numeroDeBatalhasNaEtapa0');

    //Vamos retornar as batalhas da etapa 0, e as demais serão calculadas pelos vencedores (y)
    return batalhas;
  }
}
