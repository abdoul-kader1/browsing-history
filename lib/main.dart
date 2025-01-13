import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
        routerConfig: GoRouter(
            initialLocation:'/',
            routes: [
              ShellRoute(
                  routes: [
                    GoRoute(path: '/',builder: (context,state)=>const MyHomePage(title: 'Flutter Demo Home Page')),
                    GoRoute(path: '/page-one',builder: (context,state)=>PageOne()),
                    GoRoute(path: '/page-two',builder: (context,state)=>PageTwo(commande: state.extra as CommandeModele)),
                  ],
                  builder: (context,state,child){
                    return Scaffold(
                      body: Row(
                        children: [
                          Expanded(
                            flex: 2,
                              child: Container(
                                color: Colors.brown,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(onPressed: (){context.go("/");}, child: Text("MyHomePage")),
                                    const SizedBox(height: 10),
                                    ElevatedButton(onPressed: (){context.go("/page-one");}, child: Text("page one")),
                                  ],
                                ),
                              )
                          ),
                          Expanded(
                              flex: 10,
                              child: Container(
                                child: child,
                              )
                          )
                        ],
                      ),
                    );
                  }
              ),
            ]
        )
    );
  }
}

/// my home page
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'My home page',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}

/// page one
class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: CommandeController.commandes.length,
          itemBuilder: (ctx,index){
          final valeur = CommandeController.commandes[index];
          return ListTile(
            leading: Texte(valeur.numeroCommandes.toString()),
            title: Texte("Statut :${valeur.status!}"),
            subtitle: Texte("${valeur.prix.toString()} fr"),
            trailing: Texte(valeur.heure!),
            onTap: (){
              context.go("/page-two",extra: valeur);
            },
          );
          }
      ),
    );
  }
}

///page of details
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

///controller of the commande
class CommandeController{
  static List<CommandeModele>commandes = [
    CommandeModele(numeroCommandes: 1001,date: "31 décem 2024",heure: "18h39",status: "En attente",prix: 30000,nom: "Serifou",prenom: "Abdoul-kader"),
    CommandeModele(numeroCommandes: 1002,date: "31 décem 2024",heure: "18h39",status: "Confirmé",prix: 20000,nom: "Serifou",prenom: "Abdoul-kader"),
    CommandeModele(numeroCommandes: 1003,date: "31 décem 2024",heure: "18h39",status: "Traitement",prix: 450000,nom: "Serifou",prenom: "Abdoul-kader"),
    CommandeModele(numeroCommandes: 1004,date: "31 décem 2024",heure: "18h39",status: "En livraison",prix: 50000,nom: "Serifou",prenom: "Abdoul-kader"),
    CommandeModele(numeroCommandes: 1005,date: "31 décem 2024",heure: "18h39",status: "Livré",prix: 1000,nom: "Serifou",prenom: "Abdoul-kader"),
    CommandeModele(numeroCommandes: 1006,date: "31 décem 2024",heure: "18h39",status: "Annulé",prix: 430000,nom: "Serifou",prenom: "Abdoul-kader"),
    CommandeModele(numeroCommandes: 1007,date: "31 décem 2024",heure: "18h39",status: "En attente",prix: 100000,nom: "Serifou",prenom: "Abdoul-kader"),
  ];
  static List<String> colonneCommandes = ["Numéros commandes","Date et heure","information clients","Montant total","Status","Actions"];
  static int rowsPerPage = 5;
  CommandeController();
}

/// widget text
class Texte extends Text{
  Texte(String texte,{
    super.key,TextAlign?alignementTexte,Color?couleur,double?taille,FontWeight?poids,double?hauteur,int?maxLines,
    TextOverflow?textOverflow,TextDecoration?textDecoration,Color?decorationColors,double?decorationThickness,
    Paint?paint
  }):super(
      texte,
      textAlign: alignementTexte,
      maxLines: maxLines,
      overflow: textOverflow,
      style: TextStyle(
        fontSize: taille,
        fontWeight: poids,
        letterSpacing: 1.5,
        color: couleur,
        height: hauteur,
        decoration:textDecoration,
        decorationColor: decorationColors,
        decorationThickness:decorationThickness,
        foreground:paint,
      )
  );
}

/// modele dataTable
abstract class DataTableModele{
  bool?isActive;
  String?titre,designation,icone,description,nom,prenom,email,telephone,adresse;
  int?id,stock,prix,nombreCommande,numeroCommandes;
  String?marque,date,image,descriptionMur,nombreArticleVendu,photoCouverture;
  String?heure,status;
  DataTableModele({
    this.id,this.designation,this.icone,this.description,this.isActive,
    this.image,this.stock,this.marque,this.prix,this.date,this.titre,
    this.nom,this.prenom,this.email,this.telephone,this.adresse,this.nombreCommande,
    this.descriptionMur,this.nombreArticleVendu,this.photoCouverture,this.numeroCommandes,
    this.heure,this.status
  });
}

/// model of the commande
class CommandeModele extends DataTableModele{
  CommandeModele.nulls();
  CommandeModele({super.numeroCommandes,super.date,super.heure,super.status,super.prix,super.nom,super.prenom});
}

/*
 context.go("/page-two",extra: e.value);
 */

