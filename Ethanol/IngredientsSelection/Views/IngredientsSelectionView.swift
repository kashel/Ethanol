//

import SwiftUI

struct IngredientsSelectionView: View {
  @Environment(\.injected) private var injected: DependencyContainer

  var body: some View {
    VStack {
      Text("test")
      Text("test")
    }
  }
}

struct IngredientsSelectionView_Previews: PreviewProvider {
  static var previews: some View {
    IngredientsSelectionView()
  }
}
