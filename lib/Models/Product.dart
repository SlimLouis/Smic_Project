class Product {
  final String titre;
  final String description;
  final String prix;

  Product(this.titre, this.description, this.prix);

  Map toJson() => {
    'titre': titre,
    'description': description,
    'prix': prix
  };

  Product.fromJson(Map json) :
  titre = json['titre'],
  description = json['description'],
  prix = json['prix'];
}