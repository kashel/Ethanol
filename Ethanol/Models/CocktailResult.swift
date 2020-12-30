import Foundation

public struct CocktailResult {
  let cocktail: Cocktail
  let missingIngredients: Set<String>
}
