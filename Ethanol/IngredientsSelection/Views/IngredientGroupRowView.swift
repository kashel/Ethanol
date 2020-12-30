import SwiftUI

struct IngredientGroupRowView: View {
  @Environment(\.injected) private var injected: DependencyContainer
  let ingredientGroup: IngredientGroup
  let ingredients: ArraySlice<Ingredient>
  let hasMore: HasMore
  enum HasMore {
    case no
    case yes(ArraySlice<Ingredient>)
  }
  
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
      if case HasMore.yes(let moreIngredients) = hasMore {
        components(for: ingredientGroup, ingredients: moreIngredients)
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
  func components(for group: IngredientGroup, ingredients: ArraySlice<Ingredient>) -> some View {
    MoreIngredientsTileView(ingredientGroup: ingredientGroup, ingredients: Array(ingredients))
      .environment(\.injected, injected)
  }
}
