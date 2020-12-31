import Combine

enum Sheet: Equatable, Identifiable {
  var id: String {
    switch self {
    case .moreIngredients:
      return "moreIngredients"
    case .selectedIngredients:
      return "selectedIngredients"
    case .filteredCocktails:
      return "filteredCocktails"
    }
  }
  
  case moreIngredients(group: IngredientGroup)
  case selectedIngredients
  case filteredCocktails
}

struct AppState {
  var ingredientSelection = IngredientSelectionObservedModel()
  var activeSheet: Sheet?
  var filteredCocktails: [CocktailResult] = []
}
