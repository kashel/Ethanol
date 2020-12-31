struct Interactors {
  let ingredientsSelection: IngredientsSelectionInteractor
  let activeSheet: ActiveSheetInteractor
  let filteredCocktails: FilteredCocktailsInteractor
  
  init(appState: Store<AppState>) {
    let loader = LocalCocktailLoaderMock()
    loader.availableCocktails = [CocktailMock.mojito, CocktailMock.whiteRussian]
    let cocktailAPI = LocalCocktailAPI(loader: loader)
    self.ingredientsSelection = BaseIngredientsSelectionInteractor(appState: appState)
    self.activeSheet = BaseActiveSheetInteractor(appState: appState)
    self.filteredCocktails = FilteredCocktailsInteractor(appState: appState, cocktailAPI: cocktailAPI)
  }

  static var stub: Interactors {
    Interactors(appState: Store<AppState>(AppState()))
  }
}
