import '../modeles/commande_m.dart';
import '../modeles/table_modele.dart';

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