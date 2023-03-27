import 'package:flutter_suivis_sante/api/api.dart';
import 'package:flutter_suivis_sante/api/local.dart';
import 'package:flutter_suivis_sante/object/mesure.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:flutter/material.dart';

class Graph extends StatelessWidget {
  const Graph({super.key});

  @override
  Widget build(BuildContext context) {
    final Poids = TextEditingController();
    final Taille = TextEditingController();
    final _Mesurekey = GlobalKey<FormState>();
    void addMesure() async {
      if (Poids.text.isEmpty || Taille.text.isEmpty) {
      } else {
        int taille = int.parse(Taille.text);
        double tailleM = taille / 100 * taille / 100;
        int poids = int.parse(Poids.text);
        double imc = poids / tailleM;
        Mesure mesure = Mesure(taille, poids, imc, DateTime.now());
        await Api.CreateMesure(mesure);
      }
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: SfCartesianChart(
                title:
                    ChartTitle(text: 'Voici votre évolution de perte de poids'),
                primaryXAxis: DateTimeAxis(),
                series: <ChartSeries>[
                  LineSeries<Mesure, dynamic>(
                    dataSource: Local.listemesures,
                    xValueMapper: (Mesure data, index) => data.getDateMesure(),
                    yValueMapper: (Mesure data, index) => data.getPoids(),
                  )
                ]),
          ),
          Center(
            child: Form(
              key: _Mesurekey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: TextField(
                        controller: Poids,
                        decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "Poids",

                          hintText: "Entrer votre poids", //hint text
                          focusColor: Colors.black,

                          labelStyle:
                              TextStyle(color: Colors.black), //label style
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Colors.green), //<-- SEE HERE
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Colors.black), //<-- SEE HERE
                          ),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: TextField(
                        controller: Taille,
                        decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "Taille en cm",
                          hintText: "Entrer votre taille en cm", //hint text
                          focusColor: Colors.green,
                          labelStyle:
                              TextStyle(color: Colors.black), //label style
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3, color: Colors.green), //<-- SEE HERE
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Colors.black), //<-- SEE HERE
                          ),
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                                MediaQuery.of(context).size.width / 1.50, 70),
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            side: const BorderSide(
                                width: 1, color: Colors.white)),
                        onPressed: addMesure,
                        child: const Text("Ajouter une mesure")),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
