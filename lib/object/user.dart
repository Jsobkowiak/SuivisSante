class User {
  String _email;
  String _nom;
  String _prenom;
  String _mdp;

  User(this._email, this._nom, this._prenom, this._mdp);

  String getEmail() {
    return _email;
  }

  String getNom() {
    return _nom;
  }

  String getPrenom() {
    return _prenom;
  }

  String getMdp() {
    return _mdp;
  }
}
