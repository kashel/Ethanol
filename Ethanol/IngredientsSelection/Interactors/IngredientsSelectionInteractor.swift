
protocol IngredientsSelectionInteractor {
  func select(ingredient: Ingredient)
  func deselect(ingredient: Ingredient)
  func deselectAll()
}

struct BaseIngredientsSelectionInteractor: IngredientsSelectionInteractor {
  private var appState: Store<AppState>

  init(appState: Store<AppState>) {
    self.appState = appState
  }

  func select(ingredient: Ingredient) {
    change(ingredient: ingredient, isSelected: true)
  }

  func deselect(ingredient: Ingredient) {
    change(ingredient: ingredient, isSelected: false)
  }
  
  func deselectAll() {
    let ingredients = appState[\.ingredientSelection.ingredients].map({ Ingredient(name: $0.name, imageName: $0.imageName, groups: $0.groups, isSelected: false) })
    appState[\.ingredientSelection.ingredients] = ingredients
  }
  
  private func change(ingredient: Ingredient, isSelected: Bool) {
    guard let index = appState[\.ingredientSelection.ingredients].firstIndex(where: {$0 == ingredient}) else {
      return
    }
    var mutableIngredient = appState[\.ingredientSelection.ingredients][index]
    appState[\.ingredientSelection.ingredients].remove(at: index)
    mutableIngredient.isSelected = isSelected
    appState[\.ingredientSelection.ingredients].insert(mutableIngredient, at: index)
  }
}


