import SwiftUI

struct CocktailsListItemView: View {
  let cocktailResult: CocktailResult
  
  var body: some View {
    HStack {
      Text(cocktailResult.cocktail.name)
      VStack {
        Text(cocktailResult.cocktail.name)
        Text(cocktailResult.cocktail.description)
//        ScrollView(.horizontal) {
//          HStack {
//            ForEach(cocktailResult.cocktail.ingredients, id: \.self) {
//              tag(with: $0.id)
//            }
//          }
//        }
      }
    }
  }
}

private extension CocktailsListItemView {
  func tag(with ingredientName: String) -> some View {
    Text(ingredientName)
      .padding(8)
      .background(
        RoundedRectangle(cornerRadius: 14)
          .fill(Color.green.opacity(0.2))
       )
  }
}
