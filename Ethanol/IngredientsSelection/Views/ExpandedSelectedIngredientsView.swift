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
            Text($0.name)
          }
          .onDelete(perform: { indexSet in
            guard let offset = indexSet.first else {
              return
            }
            injected.interactors.ingredientsSelection.deselect(ingredient: ingredients[offset])
          })
        }
        .navigationBarTitle("Test")
        .navigationBarTitleDisplayMode(.large)
        .environment(\.editMode, $editMode)
      }
      .onReceive(update, perform: { selection = $0 })
    }
}

struct SelectedIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandedSelectedIngredientsView()
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

