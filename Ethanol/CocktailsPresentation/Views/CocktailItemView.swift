import SwiftUI

struct CocktailItemView: View {
  let cocktailResult: CocktailResult
  
  var body: some View {
    Text(cocktailResult.cocktail.name)
  }
}

struct CocktailItemView_Preview: PreviewProvider {
  static var previews: some View {
    CocktailItemView(cocktailResult: CocktailResult(cocktail: CocktailMock.mojito, missingIngredients: ["white rum"]))
  }
}
