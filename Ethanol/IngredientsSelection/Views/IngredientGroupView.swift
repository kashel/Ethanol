//

import Combine
import SwiftUI

struct IngredientGroupView: View {
  @Environment(\.injected) private var injected: DependencyContainer
  @State private var selection: IngredientSelectionObservedModel = .init()
  
  let ingredientGroup: IngredientGroup
  
  var body: some View {
    VStack {
      HStack {
        Text(ingredientGroup.name)
        Spacer()
      }
      ScrollView(.horizontal) {
        HStack {
          ForEach(selection.ingredients.filter { !$0.isSelected && $0.groups.contains(ingredientGroup) }, id: \.self) {
            let currentIngredient = $0
            IngredientTileView(ingredient: $0)
              .onTapGesture {
                select(ingredient: currentIngredient)
              }
          }
        }
      }
    }
    .padding()
    .onReceive(update, perform: { selection = $0 })
  }
}

struct IngredientGroupView_Previews: PreviewProvider {
    static var previews: some View {
      let group = IngredientGroup.common
        IngredientGroupView(ingredientGroup: group)
          .environment(\.injected, DependencyContainer.defaultValue)
    }
}

private extension IngredientGroupView {
  func select(ingredient: Ingredient) {
    injected.interactors.ingredientsSelection.select(ingredient: ingredient)
  }
}

private extension IngredientGroupView {
  var update: AnyPublisher<IngredientSelectionObservedModel, Never> {
      injected.appState.updates(for: \.ingredientSelection)
  }
}
