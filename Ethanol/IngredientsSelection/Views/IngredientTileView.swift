//

import SwiftUI

struct IngredientTileView: View {
  let ingredient: Ingredient
  @State var tileSize = TileSize()
  
  var body: some View {
    ZStack {
      Image(ingredient.imageName)
        .resizable()
        .aspectRatio(1, contentMode: .fit)
        .padding()
        .offset(CGSize(width: 0.0, height: -10.0))
      VStack {
        Spacer()
        Text(ingredient.name)
          .foregroundColor(Color.white)
          .padding(.bottom, 5)
      }
    }
    .background(RadialGradient(gradient: Gradient(colors: [.clear, .black]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, startRadius: /*@START_MENU_TOKEN@*/5/*@END_MENU_TOKEN@*/, endRadius: 150))
    .frame(width: 90, height: 90)
    .cornerRadius(10)
  }
}

struct IngredientTileView_Previews: PreviewProvider {
  static var previews: some View {
    let orange = Ingredient(name: "orange", imageName: "orange", groups: [])
    IngredientTileView(ingredient: orange)
  }
}
