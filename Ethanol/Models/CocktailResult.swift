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

extension CocktailResult: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(cocktail)
  }
}
