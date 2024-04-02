class Favoris {
  final int id;
  final String valeur;

  const Favoris({
    required this.id,
    required this.valeur,
  });

  factory Favoris.fromJson(Map<String, dynamic> json){
    return switch(json){
      {
        'id': int id,
        'valeur': String valeur,
      } => 
      Favoris(
        id: id, 
        valeur: valeur
        ),
      _ => throw const FormatException('Failed to parse JSON to Favoris class')
    };
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'valeur': valeur
    };
  }
}