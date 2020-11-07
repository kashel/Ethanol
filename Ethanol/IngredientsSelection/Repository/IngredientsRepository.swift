import Foundation

protocol IngredientsRepository {
  var ingredientsGroups: [IngredientGroup] { get }
  func getIngredients(for: IngredientGroup) -> [Ingredient]
}

struct LocalIngredientsRepository: IngredientsRepository {
  var ingredientsGroups: [IngredientGroup] { IngredientGroup.allCases }
  
  var ingredients: Set<Ingredient> = [
    Ingredient(name: "White rum", imageName: "white_rum", groups: [.alcohols]),
    Ingredient(name: "Tequila", imageName: "tequila", groups: [.alcohols]),
    Ingredient(name: "Orange", imageName: "orange", groups: [.fruits]),
  ]
  
  func getIngredients(for group: IngredientGroup) -> [Ingredient] {
    ingredients.filter { $0.groups.contains(group) }
  }
}
