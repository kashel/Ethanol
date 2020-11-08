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
        ScrollView(.horizontal) {
          HStack {
            ForEach(ingredients, id: \.self) { ingredient in
              if !ingredient.isSelected {
                Button(action: {
                  print("tapped on igredient")
                }, label: {
                  IngredientTileView(ingredient: ingredient)
                })
              }
            }
          }
        }
      }
      .padding()
    }
}

struct IngredientGroupView_Previews: PreviewProvider {
    static var previews: some View {
      let model = IngredientsModel()
      let ingredientsRepository = LocalIngredientsRepository(model: model)
      let group = IngredientGroup.alcohols
      let ingredients = ingredientsRepository.getIngredients(for: group)
        IngredientGroupView(ingredientGroup: group, ingredients: ingredients)
    }
}
 
