import SwiftUI

struct MoreIngredientsTile: View {
  let ingredients: [Ingredient]
  
  var body: some View {
    VStack {
      ForEach(0..<2) {
        let row = $0
        HStack {
          ForEach(0..<2) {
              let column = $0
              let index = row*2+column
              if index < ingredients.count {
                let ingredient = ingredients[index]
                Image(ingredient.imageName)
                  .resizable()
                  .aspectRatio(1, contentMode: .fit)
                  .padding(1)
                  .cornerRadius(10)
              } else {
                EmptyView()
              }
            }
        }
      }
    }
    .background(Color.green)
    .frame(width: 90, height: 90)
    .cornerRadius(10)
  }
}

struct MoreIngredientsTile_Previews: PreviewProvider {
  static var previews: some View {
    var ingredients = IngredientSelectionObservedModel().ingredients
    MoreIngredientsTile(ingredients: [ingredients.removeFirst(), ingredients.removeFirst(), ingredients.removeFirst()])
  }
}
