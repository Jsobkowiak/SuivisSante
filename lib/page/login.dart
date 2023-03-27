import 'package:flutter/material.dart';
import 'package:flutter_suivis_sante/api/api.dart';
import 'package:flutter_suivis_sante/api/local.dart';
import 'package:flutter_suivis_sante/object/user.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.title});

  final String title;

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  Color loginBtn = Colors.green;
  Color registerBtn = Colors.green;
  final _loginKey = GlobalKey<FormState>();
  Row page = Row();
  String errorcode = "";
  String SuccessInfo = "";
  double setHeight = 0;
  final _emailLogin = TextEditingController();
  final _mdpLogin = TextEditingController();

  final _emailRegister = TextEditingController();
  final _passwordRegister = TextEditingController();
  final _nomRegister = TextEditingController();
  final _prenomRegister = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      setState(() {
        page = GetLoginPage();
      });
    });

    // Could do this in one line: Future.delayed(Duration.zero, this._getCategories);
  }

  void connect() async {
    if (_emailLogin.text.isEmpty || _mdpLogin.text.isEmpty) {
      setState(() {
        errorcode = "Veuillez remplir les champs au-dessus";
        page = GetLoginPage();
      });
    } else {
      await Api.Connected(_emailLogin.text, _mdpLogin.text);
      await Api.GetMusureByUserID();
      if (Local.Token.isNotEmpty) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, "/mainpage");
      } else {
        setState(() {
          errorcode = "Email ou mot de passe incorrect !";
          page = GetLoginPage();
        });
      }
    }
  }





  void Register() async {
    if (_emailRegister.text.isEmpty ||
        _passwordRegister.text.isEmpty ||
        _nomRegister.text.isEmpty ||
        _prenomRegister.text.isEmpty) {
      errorcode = "Veuillez remplir les champs au-dessus";
    } else {
      User newUser = User(_emailRegister.text, _nomRegister.text,
          _prenomRegister.text, _passwordRegister.text);
      await Api.CreateUser(newUser);
      if (Api.codeResponse == "201") {
        setState(() {
          SuccessInfo =
              "Le compte a était créer avec success, vous pouvez maintenant vous connectez.";
          setHeight = 100;
          page = GetLoginPage();
        });
      }
    }
  }

  Row GetLoginPage() {
    loginBtn = Color.fromARGB(255, 17, 73, 36);
    registerBtn = Colors.green;
    return Row(
      children: [
        Center(
          child: Column(children: [
            Container(
                margin: const EdgeInsets.all(10.0),
                child: const Text(
                  "Se connecter",
                  style: TextStyle(color: Colors.black, fontSize: 30),
                )),
            Form(
                key: _loginKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: TextField(
                          controller: _emailLogin,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: "Email",
                            hintText: "Enter your email", //hint text
                            focusColor: Colors.black,

                            labelStyle: const TextStyle(
                                color: Colors.black), //label style
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.green), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.black), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: TextField(
                          obscureText: true,
                          controller: _mdpLogin,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: "Password",
                            hintText: "Enter your password", //hint text
                            focusColor: Colors.green,
                            labelStyle: const TextStyle(
                                color: Colors.black), //label style
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.green), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.black), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(50.0),
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
                          onPressed: connect,
                          child: const Text("Connexion")),
                    ),
                    Container(
                        margin: const EdgeInsets.all(10.0),
                        child: Text(
                          errorcode,
                        )),
                  ],
                ))
          ]),
        )
      ],
    );
  }

  Row GetRegisterPage() {
    loginBtn = Colors.green;
    registerBtn = Color.fromARGB(255, 17, 73, 36);
    return Row(
      children: [
        Center(
          child: Column(children: [
            Container(
                margin: const EdgeInsets.all(10.0),
                child: const Text(
                  "S'inscrire",
                  style: TextStyle(color: Colors.black, fontSize: 30),
                )),
            Form(
                key: _loginKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: TextField(
                          controller: _emailRegister,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: "Email",
                            hintText: "Enter your email", //hint text
                            focusColor: Colors.black,

                            labelStyle: const TextStyle(
                                color: Colors.black), //label style
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.green), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.black), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: TextField(
                          obscureText: true,
                          controller: _passwordRegister,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: "Password",
                            hintText: "Enter your password", //hint text
                            focusColor: Colors.green,
                            labelStyle: const TextStyle(
                                color: Colors.black), //label style
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.green), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.black), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: TextField(
                          controller: _nomRegister,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: "Nom",
                            hintText: "Entrer votre nom", //hint text
                            focusColor: Colors.black,

                            labelStyle: const TextStyle(
                                color: Colors.black), //label style
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.green), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.black), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: TextField(
                          controller: _prenomRegister,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: "Prenom",
                            hintText: "Entrer votre prenom", //hint text
                            focusColor: Colors.black,

                            labelStyle: const TextStyle(
                                color: Colors.black), //label style
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.green), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.black), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(50.0),
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
                          onPressed: Register,
                          child: const Text("Inscription")),
                    ),
                    Container(
                        margin: const EdgeInsets.all(10.0),
                        child: Text(
                          errorcode,
                        )),
                  ],
                ))
          ]),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
      child: Column(
        children: [
          Image.asset(
            "Assets/Images/LogoSuivisSante.png",
            width: MediaQuery.of(context).size.width / 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(MediaQuery.of(context).size.width / 2, 50),
                      backgroundColor: loginBtn,
                      foregroundColor: Colors.white),
                  onPressed: () {
                    setState(() {
                      page = GetLoginPage();
                    });
                  },
                  child: const Text("Connexion")),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(MediaQuery.of(context).size.width / 2, 50),
                      backgroundColor: registerBtn,
                      foregroundColor: Colors.white),
                  onPressed: () {
                    setState(() {
                      page = GetRegisterPage();
                    });
                  },
                  child: const Text("Inscription")),
            ],
          ),
          Container(
            width: 300,
            height: setHeight,
            color: Colors.green,
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(15),
            alignment: Alignment.center,
            child: Text(SuccessInfo, style: TextStyle(fontSize: 12)),
          ),
          page
        ],
      ),
    )));
  }
}
