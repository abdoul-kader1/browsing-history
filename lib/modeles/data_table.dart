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