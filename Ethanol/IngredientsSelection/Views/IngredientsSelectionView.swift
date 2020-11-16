//

import SwiftUI
import Combine

struct IngredientsSelectionView: View {
  @Environment(\.injected) private var injected: DependencyContainer

  var body: some View {
    VStack {
      ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
        ForEach(IngredientGroup.allCases, id: \.self) {
          components(for: $0)
        }
      })
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
