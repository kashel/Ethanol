//

import SwiftUI

struct IngredientGroupView: View {
  @Environment(\.injected) private var injected: DependencyContainer
  @State private var selection: IngredientSelectionObservedModel = .init()
  
  let ingredientGroup: IngredientGroup
  
  var body: some View {
    VStack {
      HStack {
        Text(ingredientGroup.name)
        Spacer()
      }
      HStack {
        ForEach(selection.ingredients.filter { !$0.isSelected && $0.groups.contains(ingredientGroup) }, id: \.self) {
          IngredientTileView(ingredient: $0)          }
      }
    }
    .padding()
  }
}

struct IngredientGroupView_Previews: PreviewProvider {
    static var previews: some View {
      let ingredientsRepository = LocalIngredientsRepository()
      let group = IngredientGroup.alcohols
      let ingredients = ingredientsRepository.getIngredients(for: group)
        IngredientGroupView(ingredientGroup: group)
          .environment(\.injected, DependencyContainer.defaultValue)
    }
}
