class Recipe {
  String? strMeal;
  String? strCategory;
  String? strArea;
  String? strInstructions;
  String? strMealThumb;
  List<String>? ingredients;
  String? youtubeLink;

  Recipe({
    this.strMeal,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.ingredients,
    this.youtubeLink,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    List<String> ingredientList = [];

    if (json['ingredients'] != null) {
      if (json['ingredients'] is List) {
        ingredientList = List<String>.from(json['ingredients']);
      } else {
        ingredientList.add(json['ingredients'].toString());
      }
    }

    return Recipe(
      strMeal: json['strMeal'],
      strCategory: json['strCategory'],
      strArea: json['strArea'],
      strInstructions: json['strInstructions'],
      strMealThumb: json['strMealThumb'],
      ingredients: ingredientList,
      youtubeLink: json['youtubeLink'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'strMeal': strMeal,
      'strCategory': strCategory,
      'strArea': strArea,
      'strInstructions': strInstructions,
      'strMealThumb': strMealThumb,
      'ingredients': ingredients,
      'youtubeLink': youtubeLink,
    };
  }
}