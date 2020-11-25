
protocol IngredientsSelectionInteractor {
  func select(ingredient: Ingredient)
  func deselect(ingredient: Ingredient)
}

struct BaseIngredientsSelectionInteractor: IngredientsSelectionInteractor {
  private var appState: Store<AppState>

  init(appState: Store<AppState>) {
    self.appState = appState
  }

  func select(ingredient: Ingredient) {
    guard var index = appState[\.ingredientSelection.ingredients].firstIndex(where: {$0 == ingredient}) else {
      return
    }
    var mutableIngredient = appState[\.ingredientSelection.ingredients][index]
    appState[\.ingredientSelection.ingredients].remove(at: index)
    mutableIngredient.isSelected = true
    appState[\.ingredientSelection.ingredients].insert(mutableIngredient, at: index)
  }

  func deselect(ingredient: Ingredient) {
    guard var index = appState[\.ingredientSelection.ingredients].firstIndex(where: {$0 == ingredient}) else {
      return
    }
    var mutableIngredient = appState[\.ingredientSelection.ingredients][index]
    appState[\.ingredientSelection.ingredients].remove(at: index)
    mutableIngredient.isSelected = false
    appState[\.ingredientSelection.ingredients].insert(mutableIngredient, at: index)
  }


}


