import Foundation

public struct CocktailResult {
  let cocktail: Cocktail
  let missingIngredients: Set<String>
}

extension CocktailResult: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.cocktail == rhs.cocktail
  }
}
