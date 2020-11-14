//

import SwiftUI
import Combine

struct IngredientsSelectionView: View {
  @Environment(\.injected) private var injected: DependencyContainer
  @State private var selection: IngredientSelectionObservedModel = .init()

  var body: some View {
    VStack {
    }
  }
}

struct IngredientsSelectionView_Previews: PreviewProvider {
  static var previews: some View {
    IngredientsSelectionView()
  }
}
