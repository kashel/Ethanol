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
          availableWidth: geometryProxy.size.width, data: [
            "Here’s", "to", "the", "crazy", "ones", "the", "misfits", "the", "rebels", "the", "troublemakers", "the", "round", "pegs", "in", "the", "square", "holes", "the", "ones", "who", "see", "things", "differently", "they’re", "not", "fond", "of", "rules"
          ],
            spacing: 15,
            alignment: .leading
          ) { item in
            Text(verbatim: item)
              .padding(8)
              .background(
                RoundedRectangle(cornerRadius: 8)
                  .fill(Color.gray.opacity(0.2))
               )
          }
      }.padding()
    }
}

private extension CollapsedSelectedIngredientsView {
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

