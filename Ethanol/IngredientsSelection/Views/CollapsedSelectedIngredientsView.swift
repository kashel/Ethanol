//

import SwiftUI
import Combine

struct CollapsedSelectedIngredientsView: View {
  @Environment(\.injected) private var injected: DependencyContainer
  @State private var selection: IngredientSelectionObservedModel = .init()

  @State private var editMode = EditMode.active
  
    var body: some View {
      GeometryReader { geometryProxy in
        FlexibleView(
          availableWidth: geometryProxy.size.width, data: ingredients.map(\.name),
            spacing: 15,
            alignment: .leading
          ) { item in
          tag(with: item)
          }
        .fixedSize(horizontal: false, vertical: true)
      }
      .padding()
      .onReceive(update, perform: { selection = $0 })
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

