import Foundation
import Combine


struct FilteredCocktailsInteractor {
  private var appState: Store<AppState>
  private let cocktailAPI: CocktailAPI
  private var cancelable: AnyCancellable!
  
  init(appState: Store<AppState>, cocktailAPI: CocktailAPI) {
    self.appState = appState
    self.cocktailAPI = cocktailAPI
    self.cancelable = self.update.flatMap { (ingredientSelection) -> AnyPublisher<[CocktailResult], Error> in
      let selectedIngredientNames = ingredientSelection.ingredients.filter{ $0.isSelected }.map{ $0.name }
      return cocktailAPI.getCocktails(with: Set(selectedIngredientNames))
    }.sink(receiveCompletion: {_ in print("completed")}) { results in
      appState[\.filteredCocktails] = results
    }
  }
}
  
private extension FilteredCocktailsInteractor {
  var update: AnyPublisher<IngredientSelectionObservedModel, Never> {
    appState.updates(for: \.ingredientSelection)
  }
}
