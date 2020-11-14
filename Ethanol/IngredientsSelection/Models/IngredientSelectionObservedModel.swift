struct IngredientSelectionObservedModel: Equatable {
  var ingredients = Self.allIngredients
}

private extension IngredientSelectionObservedModel {
  static var allIngredients: Set<Ingredient>  {
    [Ingredient(name: "White rum", imageName: "white_rum", groups: [.alcohols]),
     Ingredient(name: "Tequila", imageName: "tequila", groups: [.alcohols]),
     Ingredient(name: "Vodka", imageName: "tequila", groups: [.alcohols]),
     Ingredient(name: "Orange", imageName: "orange", groups: [.fruits]),
     Ingredient(name: "Apple", imageName: "orange", groups: [.fruits]),
     Ingredient(name: "Banana", imageName: "orange", groups: [.fruits])]
  }
}
