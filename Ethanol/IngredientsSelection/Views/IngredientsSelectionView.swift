//

import SwiftUI
import Combine

struct IngredientsSelectionView: View {
  @Environment(\.injected) private var injected: DependencyContainer
  @State private var selection: IngredientSelectionObservedModel = .init()

  var body: some View {
    VStack {

      //      Text(selection.test1)
      //      Text(selection.test2)
      //      Button("Button") {
      //        injected.appState[\.selection.test1] = "whiskey"
    }
    .onReceive(stringUpdate) { selection = $0 }
  }
}

struct IngredientsSelectionView_Previews: PreviewProvider {
  static var previews: some View {
    IngredientsSelectionView()
  }
}

private extension IngredientsSelectionView {

    var stringUpdate: AnyPublisher<IngredientSelectionObservedModel, Never> {
        injected.appState.updates(for: \.ingredientSelection)
    }
}
