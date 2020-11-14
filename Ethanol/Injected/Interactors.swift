struct Interactors {
  let ingredientsSelection: IngredientsSelectionInteractor

  init(appState: Store<AppState>) {
    self.ingredientsSelection = BaseIngredientsSelectionInteractor(appState: appState)
  }

}
