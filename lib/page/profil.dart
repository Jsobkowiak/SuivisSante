import 'package:flutter/material.dart';
import 'package:flutter_suivis_sante/api/local.dart';

class Profil extends StatelessWidget {
  const Profil({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.person_pin,
            size: 180,
            color: Colors.green,
          ),
          Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.94,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        offset: Offset(2.0, 2.0))
                  ],
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: Text(
                      "Email : " + Local.email,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                ],
              )),
          Container(
              margin: const EdgeInsets.all(20),
              height: 50,
              width: MediaQuery.of(context).size.width * 0.90,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        offset: Offset(2.0, 2.0))
                  ],
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Nom : " + Local.nom,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                ],
              )),
          Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.90,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        offset: Offset(2.0, 2.0))
                  ],
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Prenom : " + Local.prenom,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              )),
        ],
      ),
    ));
  }
}
