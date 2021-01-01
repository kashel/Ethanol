import SwiftUI
import Combine

struct CocktailsListView: View {
  @Environment(\.injected) private var injected: DependencyContainer
  @State private var filteredCoctails: [CocktailResult] = []
  
  var body: some View {
    NavigationView {
      List(filteredCoctails, id: \.self) {
        let result = $0
        NavigationLink.init(
          destination: CocktailItemView(cocktailResult: $0),
          label: {
            CocktailsListItemView(cocktailResult: result)
          })
      }
      .navigationTitle("Matching cocktails")
    }
    .onReceive(update, perform: { filteredCoctails = $0 })
  }
}

private extension CocktailsListView {
  var update: AnyPublisher<[CocktailResult], Never> {
    injected.appState.updates(for: \.filteredCocktails)
  }
}

struct CocktailsListView_Previews: PreviewProvider {
  static var previews: some View {
    let dependencyContainer = DependencyContainer.defaultValue
    let in1: Ingredient = dependencyContainer.appState[\.ingredientSelection].ingredients.first{ $0.name == "ice" }!
    let in2: Ingredient = dependencyContainer.appState[\.ingredientSelection].ingredients.first{ $0.name == "white rum" }!
    let in3: Ingredient = dependencyContainer.appState[\.ingredientSelection].ingredients.first{ $0.name == "mint" }!
    dependencyContainer.interactors.ingredientsSelection.select(ingredient: in1)
    dependencyContainer.interactors.ingredientsSelection.select(ingredient: in2)
    dependencyContainer.interactors.ingredientsSelection.select(ingredient: in3)
    return CocktailsListView()
      .environment(\.injected, dependencyContainer)
    
  }
}
