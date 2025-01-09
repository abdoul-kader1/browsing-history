import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_web/widgets/texte.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

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
      Texte(e.value.toString(), taille: 12,couleur: Colors.white,),
    );
  }
}
