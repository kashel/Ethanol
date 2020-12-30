import SwiftUI

struct IngredientGroupRowView: View {
  @Environment(\.injected) private var injected: DependencyContainer
  let ingredientGroup: IngredientGroup
  let ingredients: ArraySlice<Ingredient>
  let hasMore: Bool
  
  struct IngredientGroupRowViewParams {
    let initialIndex: Int
    let upperBound: Int
  }
  
  var body: some View {
    HStack {
      ForEach(ingredients, id: \.self) { currentIngredient in
        IngredientTileView(ingredient: currentIngredient)
          .onTapGesture {
            select(ingredient: currentIngredient)
          }
      }
      if hasMore {
        components(for: ingredientGroup)
      }
    }
  }
}


private extension IngredientGroupRowView {
  func select(ingredient: Ingredient) {
    injected.interactors.ingredientsSelection.select(ingredient: ingredient)
  }
}

private extension IngredientGroupRowView {
  func components(for group: IngredientGroup) -> some View {
    MoreIngredientsTileView(ingredientGroup: ingredientGroup)
      .environment(\.injected, injected)
  }
}
