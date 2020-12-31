import SwiftUI
import Combine

struct CocktailsListView: View {
  @Environment private var injected: DependencyContainer
  @State private var filteredCoctails: [CocktailResult]
  
  var body: some View {
    VStack {
      ForEach(filteredCoctails, id:\.self) {
        CocktailsListItemView(cocktailResult: $0)
      }
    }
    .onReceive(update, perform: { filteredCoctails = $0 })
  }
}

private extension CocktailsListView {
  var update: AnyPublisher<[CocktailResult], Never> {
    injected.appState.updates(for: \.filteredCocktails)
  }
}
