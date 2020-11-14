
protocol IngredientsSelectionInteractor {
  func select(ingredient: Ingredient)
}

struct BaseIngredientsSelectionInteractor: IngredientsSelectionInteractor {
  private var appState: Store<AppState>

  init(appState: Store<AppState>) {
    self.appState = appState
  }

  func select(ingredient: Ingredient) {
    guard var mutableIngredient = appState[\.ingredientSelection.ingredients].first(where: {$0 == ingredient}) else {
      return
    }
    appState[\.ingredientSelection.ingredients].remove(mutableIngredient)
    mutableIngredient.isSelected = true
    appState[\.ingredientSelection.ingredients].insert(mutableIngredient)
  }


}


