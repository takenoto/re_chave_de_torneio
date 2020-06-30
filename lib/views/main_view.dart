import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rechavedetorneio/get_data/data.dart' as data;
import 'package:rechavedetorneio/models/competidor_model.dart';
import 'package:rechavedetorneio/views/chave_de_torneio_view.dart';
import 'package:rechavedetorneio/views/widgets/competidor_widget.dart';
import 'package:rechavedetorneio/views/widgets/dimensoes_e_etc.dart' as info;

double _sliderPoint = 1;

//Variáveis que serão passadas para a chave de torneio quando ela for criada!
int numCompetidoresInicio = 2;
double heightCompetidor = info.competidorHeight;
double widthCompetidor = info.competidorWidth;
Color winnerColor = info.competidorWinnerColor;
int numeroN = 1;

//Widgets com as propriedades:
List<Widget> widgetsDasProps = [
  NumeroDeJogadoresPicker(),
  HeightDoJogadorWidget(),
  CorDoVencedorWidget()
];

class MainView extends StatelessWidget {
  static String routeName = 'MainView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Icon(
                          Icons.offline_bolt,
                          color: Colors.amber,
                          size: 120,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'CHAVE DE TORNEIO'.toUpperCase(),
                          style: info.textoDestaque,
                        ),
                      ),
                      Container(
                        color: Colors.amber,
                        height: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: FlatButton(
                          child: Text('PERSONALIZAR'),
                          padding: EdgeInsets.all(16),
                          color: Colors.white,
                          onPressed: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child: Scaffold(
                                      body: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                child: EditaPropsWidget(),
                                                color: Colors.blueGrey[700],
                                              ),
                                            ),
                                            FlatButton(
                                              padding: EdgeInsets.all(16),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.blue,
                                                size: 40,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 16,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            FlatButton(
              child: Text('CRIAR'),
              padding: EdgeInsets.all(16),
              color: Colors.amber,
              onPressed: () {
                updateValues();
                Navigator.pushNamed(context, ChaveDeTorneioView.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}

//Atualiza os valores da classe a ser criada com os determinados pelo usuário!
void updateValues() {
  data.numeroDeCompetidoresNoInicio = numCompetidoresInicio;
  info.competidorHeight = heightCompetidor;
  info.competidorWidth = widthCompetidor;
  info.competidorWinnerColor = winnerColor;
}

//BottomSheet para personalização

class NumeroDeJogadoresPicker extends StatefulWidget {
  @override
  _NumeroDeJogadoresPickerState createState() =>
      _NumeroDeJogadoresPickerState();
}

class _NumeroDeJogadoresPickerState extends State<NumeroDeJogadoresPicker> {
  void atualizarDados(String n) {
    setState(() {
      print('numeroN = $n');
      double nDouble = double.parse(n);
      numeroN = nDouble.round();
      numCompetidoresInicio = pow(2, numeroN);
    });
  }

  @override
  Widget build(BuildContext context) {
//    data.numeroDeCompetidoresNoInicio = pow(2, numeroN);

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Slider(
          value: _sliderPoint,
          max: 8,
          min: 1,
          divisions: 7,
          onChanged: (value) {
            _sliderPoint = value;
            atualizarDados(value.toString());
          },
        ),
        Text(
          '$numCompetidoresInicio competidores'.toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}


//Widget do competidor:
class ExemploWidgetCompetidorSize extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



class HeightDoJogadorWidget extends StatefulWidget {
  @override
  _HeightDoJogadorWidgetState createState() => _HeightDoJogadorWidgetState();
}

class _HeightDoJogadorWidgetState extends State<HeightDoJogadorWidget> {
  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        TextField(
          controller: TextEditingController()
            ..text = heightCompetidor.round().toString(),
          textAlign: TextAlign.start,
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700),
          keyboardType: TextInputType.numberWithOptions(decimal: false),
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              prefixIcon: Icon(
                Icons.crop_portrait,
                color: Colors.white,
              ),
              helperText: 'Height do Competidor'.toUpperCase(),
              helperStyle: info.helperStyle),
          onChanged: (value) {
            heightCompetidor = double.parse(value);
          },
        ),
        TextField(
          controller: TextEditingController()
            ..text = widthCompetidor.round().toString(),
          textAlign: TextAlign.start,
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700),
          keyboardType: TextInputType.numberWithOptions(decimal: false),
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              prefixIcon: Icon(
                Icons.crop_5_4,
                color: Colors.white,
              ),
              helperText: 'Width do Competidor'.toUpperCase(),
              helperStyle: info.helperStyle),
          onChanged: (value) {
            widthCompetidor = double.parse(value);
          },
        ),

      ],
    );
  }
}

//Propriedades a serem passadas e editadas manualmente são exibidas aqui:
class EditaPropsWidget extends StatefulWidget {
  @override
  _EditaPropsWidgetState createState() => _EditaPropsWidgetState();
}

class _EditaPropsWidgetState extends State<EditaPropsWidget> {
  int _i = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        FlatButton(
            onPressed: () {
              setState(() {
                _i > 0 ? _i-- : _i = _i;
              });
            },
            child: Icon(Icons.arrow_back_ios,
                color: _i > 0 ? Colors.white : Colors.white10)),
        Expanded(
          child: widgetsDasProps[_i],
        ),
        FlatButton(
            onPressed: () {
              setState(() {
                _i < widgetsDasProps.length - 1 ? _i++ : _i = _i;
              });
            },
            child: Icon(Icons.arrow_forward_ios,
                color: _i < widgetsDasProps.length - 1
                    ? Colors.white
                    : Colors.white10)),
      ],
    );
  }
}

Color corSelecionada = winnerColor;

class CorDoVencedorWidget extends StatefulWidget {
  @override
  _CorDoVencedorWidgetState createState() => _CorDoVencedorWidgetState();
}

class _CorDoVencedorWidgetState extends State<CorDoVencedorWidget> {
  List<Color> colors = Colors.primaries;
  List<Widget> colorOptions = [];

  @override
  void initState() {
    //faz as opções das cores
    for (Color color in colors) {
      colorOptions.add(GestureDetector(
        onTap: () {
          corSelecionada = color;
          winnerColor = corSelecionada;
          setState(() {
            winnerColor = corSelecionada;
          });
        },
        child: Container(
          color: color,
          height: 70,
        ),
      ));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlatButton(
          padding: EdgeInsets.all(25),
          child: Text(
            'Selecione a cor do vencedor',
            textAlign: TextAlign.center,
            style: info.textoDestaque.copyWith(fontSize: 16),
          ),
          color: winnerColor,
          onPressed: () {
            showCupertinoDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: SingleChildScrollView(
                      child: Column(
                        children: colorOptions,
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          'OK',
                          style: TextStyle(color: winnerColor),
                        ),
                        onPressed: () {
                          winnerColor = corSelecionada;
                          print('winner color = $winnerColor');
                          Navigator.pop(context);
                          setState(() {
                            winnerColor = corSelecionada;
                            updateValues();
                          });
                        },
                      ),
                    ],
                  );
                });
          },
        )
      ],
    );
  }
}

//Antigo texto
//child: TextField(
//inputFormatters: [
//WhitelistingTextInputFormatter.digitsOnly
//],
//style: TextStyle(color: Colors.white),
//keyboardType:
//TextInputType.numberWithOptions(decimal: false),
//cursorColor: Theme.of(context).primaryColor,
//decoration: InputDecoration(
//border: OutlineInputBorder(
//borderSide: BorderSide(
//color: Colors.white,
//),
//),
//enabledBorder: OutlineInputBorder(
//borderSide: BorderSide(color: Colors.white)),
//prefixIcon: Icon(
//Icons.people,
//color: Colors.white,
//),
//labelText: 'Número de competidores'.toUpperCase(),
//labelStyle: TextStyle(
//color: Theme.of(context).primaryColor)),
//),
