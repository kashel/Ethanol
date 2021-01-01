import SwiftUI

struct CocktailIngredients: View {
  struct Ingredient: Hashable {
    let name: String
    let isAvailable: Bool
  }
  
  let cocktailResult: CocktailResult
  
  var body: some View {
    let availableIngredients = cocktailResult.cocktail.ingredients.filter({ !cocktailResult.missingIngredients.contains($0.name) })
    let availableTags = availableIngredients.map({ Ingredient(name: $0.name, isAvailable: true)})
    let unavailableTags = cocktailResult.cocktail.ingredients.subtracting(availableIngredients).map({ Ingredient(name: $0.name, isAvailable: false)})
    let tags = availableTags + unavailableTags
    FlexibleView(data: tags, spacing: 5, alignment: HorizontalAlignment.leading) { ingredient in
      tag(with: ingredient.name, isAvailable: ingredient.isAvailable)
    }
  }
}

private extension CocktailIngredients {
  func tag(with ingredientName: String, isAvailable: Bool) -> some View {
    Text(ingredientName)
      .font(.footnote)
      .padding(8)
      .background(
        RoundedRectangle(cornerRadius: 7)
          .fill(isAvailable ? Color.green.opacity(0.2) : Color.gray.opacity(0.2))
       )
  }
}

struct CocktailIngredients_Preview: PreviewProvider {
  static var previews: some View {
    CocktailIngredients(cocktailResult: CocktailResult(cocktail: CocktailMock.mojito, missingIngredients: ["white rum"]))
  }
}
