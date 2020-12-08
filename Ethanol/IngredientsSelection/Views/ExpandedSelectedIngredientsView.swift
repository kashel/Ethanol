//

import SwiftUI
import Combine

struct ExpandedSelectedIngredientsView: View {
  @Environment(\.injected) private var injected: DependencyContainer
  @State private var selection: IngredientSelectionObservedModel = .init()

  @State private var editMode = EditMode.active
  
    var body: some View {
      NavigationView {
        List {
          ForEach(ingredients, id: \.self) {
            cell(with: $0)
          }
          .onDelete(perform: { indexSet in
            guard let offset = indexSet.first else {
              return
            }
            injected.interactors.ingredientsSelection.deselect(ingredient: ingredients[offset])
          })
        }
        .navigationBarTitle("Selected ingredients")
        .navigationBarTitleDisplayMode(.large)
        .environment(\.editMode, $editMode)
      }
      .onReceive(update, perform: { selection = $0 })
    }
}

private extension ExpandedSelectedIngredientsView {
  func cell(with ingredient: Ingredient) -> some View {
    HStack {
      Image(ingredient.imageName)
        .resizable()
        .aspectRatio(1, contentMode: .fit)
        .frame(width: 32, height: 32)
      Text(ingredient.name)
    }
  }
}

struct ExpandedSelectedIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
      ExpandedSelectedIngredientsView()
        .environment(\.injected, DependencyContainer.defaultValue)
    }
}

private extension ExpandedSelectedIngredientsView {
  var update: AnyPublisher<IngredientSelectionObservedModel, Never> {
      injected.appState.updates(for: \.ingredientSelection)
  }
}

private extension ExpandedSelectedIngredientsView {
  var ingredients: [Ingredient] {
    selection.ingredients.filter(\.isSelected)
  }
}

