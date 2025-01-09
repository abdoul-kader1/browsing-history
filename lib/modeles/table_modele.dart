import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../widgets/box_table_commandes.dart';
import 'commande_m.dart';
import 'data_table.dart';

class TableDataSource<T extends DataTableModele> extends DataGridSource {

  final int rowsPerPage;
  final List<String>colonne;
  List<DataGridRow>produitsDataGridRows = [];
  List<T>paginatedRows = [];
  List<T>categoriesData = [];

  TableDataSource({required List<T>laListe,required this.rowsPerPage,required this.colonne}) {
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
        color: row.getCells()[0].value % 2 == 0 ?Colors.deepPurpleAccent: Colors.deepPurpleAccent.shade100,
        cells: row.getCells().map((e) {
          return builWidgetLigne(e,paginatedRows);
        }).toList()
    );
  }

  //methode de mappage pour remplir les cellules ligne et colonne
  buildPaginatedDataGridRows(){
    produitsDataGridRows = paginatedRows.map<DataGridRow>((e){
      return DataGridRow(
          cells: [
            for(var i=0;i<colonne.length;i++)...{
              DataGridCell(columnName: colonne[i],value: buildLigne(e)[i]),
            }
          ]
      );
    }).toList();
  }
  //crée la pagination
  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex)async{
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
  Map<int,dynamic> buildLigne(T valeur){
    if(valeur.runtimeType==CommandeModele){
      return {
        0: valeur.numeroCommandes,
        1: [valeur.date,valeur.heure],
        2: [valeur.nom,valeur.prenom],
        3: valeur.prix,
        4: valeur.status,
        5: valeur
      };
    }else{return {};}
  }
  //construire le widget de la ligne
  Widget builWidgetLigne(DataGridCell<dynamic> e, List<T> paginatedRows){
    //print(T.runtimeType);
    if(paginatedRows.runtimeType==List<CommandeModele>){
      return BoxTableCommande(e: e);
    }
    else{
      return Container(color: Colors.green);
    }
  }
}