struct Interactors {
  let ingredientsSelection: IngredientsSelectionInteractor

  init(appState: Store<AppState>) {
    self.ingredientsSelection = BaseIngredientsSelectionInteractor(appState: appState)
  }

  static var stub: Interactors {
    Interactors(appState: Store<AppState>(AppState()))
  }
}
