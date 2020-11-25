struct IngredientSelectionObservedModel: Equatable {
  var ingredients = Self.allIngredients
}

private extension IngredientSelectionObservedModel {
  static var allIngredients: [Ingredient]  {
    [Ingredient(name: "White rum", imageName: "white_rum", groups: [.alcohols]),
     Ingredient(name: "Tequila", imageName: "tequila", groups: [.alcohols]),
     Ingredient(name: "Malibu", imageName: "tequila", groups: [.alcohols]),
     Ingredient(name: "Rum", imageName: "white_rum", groups: [.alcohols]),
     Ingredient(name: "Red wine", imageName: "white_rum", groups: [.alcohols]),
     Ingredient(name: "White wine", imageName: "white_rum", groups: [.alcohols]),
     Ingredient(name: "Vodka", imageName: "tequila", groups: [.alcohols, .common]),
     Ingredient(name: "Orange", imageName: "orange", groups: [.fruits, .common]),
     Ingredient(name: "Apple", imageName: "orange", groups: [.fruits, .common]),
     Ingredient(name: "Banana", imageName: "orange", groups: [.fruits])]
  }
}
