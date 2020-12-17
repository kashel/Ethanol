struct Interactors {
  let ingredientsSelection: IngredientsSelectionInteractor
  let activeSheet: ActiveSheetInteractor
  
  init(appState: Store<AppState>) {
    self.ingredientsSelection = BaseIngredientsSelectionInteractor(appState: appState)
    self.activeSheet = BaseActiveSheetInteractor(appState: appState)
  }

  static var stub: Interactors {
    Interactors(appState: Store<AppState>(AppState()))
  }
}
