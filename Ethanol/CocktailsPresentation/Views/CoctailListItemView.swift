import SwiftUI

struct CocktailsListItemView: View {
  let cocktailResult: CocktailResult
  
  var body: some View {
    HStack(spacing: 20) {
      cocktailResult.cocktail.image
        .resizable()
        .aspectRatio(1, contentMode: .fit)
        .frame(width: 150, height: 150)
      VStack(spacing: 10) {
        Text(cocktailResult.cocktail.name)
          .font(.headline)
        Text(cocktailResult.cocktail.description)
          .font(.footnote)
          .multilineTextAlignment(.leading)
        CocktailIngredients(cocktailResult: cocktailResult)
      }
    }
    .padding()
  }
}

struct CocktailsListItemView_Preview: PreviewProvider {
  @ViewBuilder static var previews: CocktailsListItemView  {
    CocktailsListItemView(cocktailResult: CocktailResult(cocktail: CocktailMock.mojito, missingIngredients: ["a", "b"]))
  }
}
