import 'package:flutter/material.dart';

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