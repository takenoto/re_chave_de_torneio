import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:rechavedetorneio/models/etapa_model.dart';
import 'package:rechavedetorneio/views/widgets/chave_de_torneio_widget.dart';
import '../brain.dart';

AsyncSnapshot<dynamic> superSnapshot;

class ChaveDeTorneioView extends StatelessWidget {
  static String routeName = 'ChaveDeTorneioView';

  @override
  Widget build(BuildContext context) {
    //new CompetidorWidget();
    return Scaffold(
        appBar: AppBar(title: Text('Chave de torneio')),
        backgroundColor: Theme.of(context).backgroundColor,
        body: FutureBuilder(
          future: obterChaveDeTorneio(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              //Etapas:
              superSnapshot = snapshot;
              return TorneioRedimensionavel();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

Future<Widget> obterChaveDeTorneio() async {
  //Obtém as etapas:
  List<EtapaModel> etapas = await Brain().gerarEtapas();
  //Cria o Widget:
  ChaveDeTorneioWidget chaveDeTorneioView =
      await obterChaveDeTorneioWidget(etapas: etapas);
  return chaveDeTorneioView;
}

Future<Widget> obterChaveDeTorneioWidget({List<EtapaModel> etapas}) async {
  return ChaveDeTorneioWidget(
    etapas: etapas,
  );
}

class TorneioRedimensionavel extends StatefulWidget {
  @override
  _TorneioRedimensionavelState createState() => _TorneioRedimensionavelState();
}

double _heightDoTorneio = 10;

class _TorneioRedimensionavelState extends State<TorneioRedimensionavel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //Visão geral da chave:
                  SizedBox(
                    height: _heightDoTorneio,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: SingleChildScrollView(
                          child: superSnapshot.data,
                        ),
                      ),
                    ),
                  ),

                  //Chave completa:
                ],
              ),
            ),
          ),
        ),
        //Gerenciador:
        Slider(
          value: _heightDoTorneio,
          min: 1,
          max: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              72,
          divisions: 100,
          onChanged: (value) {
            _heightDoTorneio = value;
            setState(() {});
          },
        ),
      ],
    );
    ;

    //ANTIGO:
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          //Visão geral da chave:
          SizedBox(
            height: 100,
            child: FittedBox(
              child: superSnapshot.data,
            ),
          ),
          //Chave completa:

          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: superSnapshot.data,
            ),
          ),
        ],
      ),
    );
  }
}
