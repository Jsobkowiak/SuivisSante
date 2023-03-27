import 'package:intl/intl.dart';

class Mesure {
  int _taille;
  int _poids;
  double _imc;
  DateTime _datemesure;

  Mesure(this._taille, this._poids, this._imc, this._datemesure);

  int getTaille() {
    return _taille;
  }

  int getPoids() {
    return _poids;
  }

  double getImc() {
    return _imc;
  }

  DateTime getDateMesure() {
    return _datemesure;
  }
  String getDateMesure2(){
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(_datemesure);
  }
}
