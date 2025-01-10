import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:syncfusion_flutter_core/theme.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                height: 645,
                color:Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                child: SfDataGridTheme(
                    data: SfDataGridThemeData(
                      headerColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
                      sortIconColor: Colors.white,
                    ),
                    child: SfDataGrid(
                        gridLinesVisibility: GridLinesVisibility.none,
                        columnWidthMode:ColumnWidthMode.fill,
                        showCheckboxColumn: true,
                        selectionMode: SelectionMode.multiple,
                        allowSorting: true,
                        allowTriStateSorting: true,
                        sortingGestureType: SortingGestureType.doubleTap,
                        source: CommandeController.commandeDataSource,
                        columns: CommandeController.colonneCommandes.map<GridColumn>((e){
                          return GridColumn(
                              allowSorting: e==CommandeController.colonneCommandes[0]||e==CommandeController.colonneCommandes[3]?true:false,
                              columnName: e, label: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              alignment: Alignment.center,child: Texte(e,couleur: Colors.white)
                          )
                          );
                        }).toList()
                    )
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

/// table widget
class BoxTableCommande extends StatelessWidget {
  final DataGridCell<dynamic> e;
  const BoxTableCommande({super.key,required this.e});

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child:e.columnName=="Date et heure"?
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Texte(e.value[0], taille: 12,textOverflow: TextOverflow.ellipsis,couleur: Colors.white,)),
                Expanded(child: Texte(e.value[1], taille: 12,textOverflow: TextOverflow.ellipsis,couleur: Colors.white,)),
              ],
            ),
          )
        ],
      ):
      e.columnName == "information clients" ?
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Texte(e.value[0], taille: 12,textOverflow: TextOverflow.ellipsis,couleur: Colors.white,)),
                Expanded(child: Texte(e.value[1], taille: 12,textOverflow: TextOverflow.ellipsis,couleur: Colors.white,)),
              ],
            ),
          )
        ],
      ) : e.columnName == "Status" ?
      Container(
          padding:const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color:Colors.yellow,
              borderRadius:BorderRadius.circular(5)
          ),
          child: Texte(e.value.toString(), taille: 12,couleur: Colors.black)
      ): e.columnName=="Actions"?IconButton(
          onPressed: (){
            context.go("/page-two",extra: e.value);
          },
          icon: const Icon(Icons.remove_red_eye, size: 20)
      ):
      Texte(e.value.toString(), taille: 12,couleur: Colors.white),
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
  static TableDataSource<CommandeModele>commandeDataSource = TableDataSource(laListe: commandes,rowsPerPage: rowsPerPage, colonne: colonneCommandes);
  CommandeController();
}

/// table construction model
class TableDataSource<T extends DataTableModele> extends DataGridSource {

  final int rowsPerPage;
  final List<String>colonne;
  List<DataGridRow>produitsDataGridRows = [];
  List<T>paginatedRows = [];
  List<T>categoriesData = [];

  TableDataSource({required List<
      T>laListe, required this.rowsPerPage, required this.colonne}) {
    paginatedRows = laListe;
    categoriesData = laListe;
    buildPaginatedDataGridRows();
  }

  @override
  List<DataGridRow> get rows => produitsDataGridRows;

  //remplir les cellules d'une ligne et colonne avec un mappage
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        color: row.getCells()[0].value % 2 == 0
            ? Colors.deepPurpleAccent
            : Colors.deepPurpleAccent.shade100,
        cells: row.getCells().map((e) {
          return builWidgetLigne(e, paginatedRows);
        }).toList()
    );
  }

  //methode de mappage pour remplir les cellules ligne et colonne
  buildPaginatedDataGridRows() {
    produitsDataGridRows = paginatedRows.map<DataGridRow>((e) {
      return DataGridRow(
          cells: [
            for(var i = 0; i < colonne.length; i++)...{
              DataGridCell(columnName: colonne[i], value: buildLigne(e)[i]),
            }
          ]
      );
    }).toList();
  }

  //crée la pagination
  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    final int startIndex = newPageIndex * rowsPerPage;
    int endIndex = startIndex + rowsPerPage;
    if (endIndex > categoriesData.length) {
      endIndex = categoriesData.length;
    }
    if (startIndex < categoriesData.length &&
        endIndex <= categoriesData.length) {
      paginatedRows = categoriesData.getRange(startIndex, endIndex).toList();
    } else {
      paginatedRows = <T>[];
    }
    buildPaginatedDataGridRows();
    notifyListeners();
    return true;
  }

  //mettre a jour le tableau de pagination
  void updateDataGriDataSource() {
    notifyListeners();
  }

  //construire la cellule
  Map<int, dynamic> buildLigne(T valeur) {
    if (valeur.runtimeType == CommandeModele) {
      return {
        0: valeur.numeroCommandes,
        1: [valeur.date, valeur.heure],
        2: [valeur.nom, valeur.prenom],
        3: valeur.prix,
        4: valeur.status,
        5: valeur
      };
    } else {
      return {};
    }
  }

  //construire le widget de la ligne
  Widget builWidgetLigne(DataGridCell<dynamic> e, List<T> paginatedRows) {
    //print(T.runtimeType);
    if (paginatedRows.runtimeType == List<CommandeModele>) {
      return BoxTableCommande(e: e);
    }
    else {
      return Container(color: Colors.green);
    }
  }
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

