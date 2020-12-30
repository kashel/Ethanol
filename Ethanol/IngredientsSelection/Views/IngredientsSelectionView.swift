//

import SwiftUI
import Combine

struct IngredientsSelectionView: View {
  @Environment(\.injected) private var injected: DependencyContainer
  @State private var selection: IngredientSelectionObservedModel = .init()
  
  var body: some View {
    VStack {
      ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
        VStack(spacing: 0) {
          ForEach(IngredientGroup.allCases, id: \.self) { ingredientGroup in
            components(for: ingredientGroup)
              .presented(selection.ingredients.filter { ingredient in
                        ingredient.groups.contains(ingredientGroup) && !ingredient.isSelected }.isEmpty == false)
          }
        }
      })
    }
    .onReceive(update, perform: { selection = $0 })
  }
}

struct IngredientsSelectionView_Previews: PreviewProvider {
  static var previews: some View {
    IngredientsSelectionView()
  }
}

private extension IngredientsSelectionView {
  func components(for group: IngredientGroup) -> some View {
    IngredientGroupView(ingredientGroup: group, backgroundColor: group.color)
      .environment(\.injected, injected)
  }
}

private extension IngredientsSelectionView {
  var update: AnyPublisher<IngredientSelectionObservedModel, Never> {
    injected.appState.updates(for: \.ingredientSelection)
  }
}
