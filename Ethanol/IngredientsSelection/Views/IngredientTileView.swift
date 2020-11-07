//

import SwiftUI

struct IngredientTileView: View {
  var body: some View {
    ZStack {
      Image("orange")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .padding()
      VStack {
        Spacer()
        Text("Orange")
          .foregroundColor(Color.white)
      }
    }
    .background(Color.green)
    .frame(width: 90, height: 90)
  }
}

struct IngredientTileView_Previews: PreviewProvider {
  static var previews: some View {
    IngredientTileView()
  }
}
