import SwiftUI

struct CocktailsListItemView: View {
  let cocktailResult: CocktailResult
  
  var body: some View {
    HStack {
      cocktailResult.cocktail.image
        .resizable()
        .aspectRatio(1, contentMode: .fit)
      VStack(spacing: 20) {
        Text(cocktailResult.cocktail.name)
          .font(.headline)
        Text(cocktailResult.cocktail.description)
          .font(.footnote)
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
