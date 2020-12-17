import SwiftUI

struct IngredientsListView: View {
  let ingredientGroup: IngredientGroup
  
  var body: some View {
    Text("more ingredients from: \(ingredientGroup.name)")
  }
}
