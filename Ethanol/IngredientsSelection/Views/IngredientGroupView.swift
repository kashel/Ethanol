//

import SwiftUI

struct IngredientGroupView: View {
  let ingredientGroup: IngredientGroup
  let ingredients: [Ingredient]
  
    var body: some View {
      VStack {
        HStack {
          Text(ingredientGroup.name)
          Spacer()
        }
        HStack {
          ForEach(ingredients, id: \.self) {
            IngredientTileView(ingredient: $0)
          }
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
        IngredientGroupView(ingredientGroup: group, ingredients: ingredients)
    }
}
