import 'package:flutter/material.dart';
import 'package:navigation_web/widgets/texte.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'controller/commande_c.dart';

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
