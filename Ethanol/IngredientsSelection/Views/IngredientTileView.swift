//

import SwiftUI

struct IngredientTileView: View {
  let ingredient: Ingredient
  
  var body: some View {
    ZStack {
      Image(ingredient.imageName)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .padding()
      VStack {
        Spacer()
        Text(ingredient.name)
          .foregroundColor(Color.white)
      }
    }
    .background(Color.green)
    .frame(width: 90, height: 90)
  }
}

struct IngredientTileView_Previews: PreviewProvider {
  static var previews: some View {
    let orange = Ingredient(name: "orange", imageName: "orange", groups: [])
    IngredientTileView(ingredient: orange)
  }
}
