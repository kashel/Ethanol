import Combine

enum Sheet: Equatable, Identifiable {
  var id: String {
    switch self {
    case .moreIngredients:
      return "moreIngredients"
    case .selectedIngredients:
      return "selectedIngredients"
    }
  }
  
  case moreIngredients(group: IngredientGroup)
  case selectedIngredients
}

struct AppState {
  var ingredientSelection = IngredientSelectionObservedModel()
  var activeSheet: Sheet?
  var filteredCocktails: [CocktailResult] = []
}
