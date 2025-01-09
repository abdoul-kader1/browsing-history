import 'package:flutter/material.dart';
import 'package:navigation_web/modeles/commande_m.dart';

class PageTwo extends StatelessWidget {
  final CommandeModele commande;
  const PageTwo({super.key,required this.commande});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Numéros commande :${commande.numeroCommandes}"),
      ),
    );
  }
}