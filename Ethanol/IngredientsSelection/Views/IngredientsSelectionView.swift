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
            .padding(.bottom, -10)
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
//      .background()
      .background(RadialGradient(gradient: Gradient(colors: [.white, group.color]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, startRadius: 10, endRadius: 300))
      .environment(\.injected, injected)
  }
}
