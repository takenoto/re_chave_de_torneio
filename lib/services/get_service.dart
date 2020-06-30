import 'dart:io';
import 'package:rechavedetorneio/models/competidor_model.dart';
import 'package:rechavedetorneio/get_data/data.dart' as Data;

class Service {
  //Simula uma requisição na web de modo besta mas simula

  int numeroDeCompetidores = 0;

  List<CompetidorModel> getBatalhasIniciais() {
    print('Obtendo batalhas 0');
    //sleep(Duration(seconds: 1));
    this.numeroDeCompetidores = Data.numeroDeCompetidoresNoInicio;

    //Cria as primeiras batalhas, baseado na ordem em que os competidores foram passados
  }
}
