//

import SwiftUI
import Combine

struct IngredientsSelectionView: View {
  @Environment(\.injected) private var injected: DependencyContainer
  @State private var selection: IngredientSelectionObservedModel = .init()

  var body: some View {
    VStack {
      ForEach(IngredientGroup.allCases, id: \.self) {
        components(for: $0)
      }
    }
  }
}

struct IngredientsSelectionView_Previews: PreviewProvider {
  static var previews: some View {
    IngredientsSelectionView()
  }
}

private extension IngredientsSelectionView {
  func components(for group: IngredientGroup) -> some View {
    IngredientGroupView(ingredientGroup: group)
      .environment(\.injected, injected)
  }
}
