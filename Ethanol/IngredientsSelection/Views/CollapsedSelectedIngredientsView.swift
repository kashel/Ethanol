//

import SwiftUI
import Combine

struct CollapsedSelectedIngredientsView: View {
  @Environment(\.injected) private var injected: DependencyContainer
  @State private var selection: IngredientSelectionObservedModel = .init()

  @State private var editMode = EditMode.active
  
    var body: some View {
      HStack {
        ScrollView(.horizontal) {
          HStack {
            ForEach(selection.ingredients.filter(\.isSelected), id: \.self) {
              tag(with: $0.name)
            }
          }
        }
        .onReceive(update, perform: { selection = $0 })
        Button(action: {
          injected.interactors.activeSheet.present(.selectedIngredients)
        }) {
          Image(systemName: "arrow.up.backward.and.arrow.down.forward")
        }
      }
    }
}

private extension CollapsedSelectedIngredientsView {
  func tag(with ingredientName: String) -> some View {
    Text(ingredientName)
      .padding(8)
      .background(
        RoundedRectangle(cornerRadius: 14)
          .fill(Color.green.opacity(0.2))
       )
  }
}

struct CollapsedSelectedIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
      CollapsedSelectedIngredientsView()
        .environment(\.injected, DependencyContainer.defaultValue)
    }
}

private extension CollapsedSelectedIngredientsView {
  var update: AnyPublisher<IngredientSelectionObservedModel, Never> {
      injected.appState.updates(for: \.ingredientSelection)
  }
}

private extension CollapsedSelectedIngredientsView {
  var ingredients: [Ingredient] {
    selection.ingredients.filter(\.isSelected)
  }
}

