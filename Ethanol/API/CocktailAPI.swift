//

import Foundation
import Combine

protocol CocktailAPI {
  func getCocktail(with ingredients: [String]) -> AnyPublisher<[Cocktail], Error>
}

struct CocktailAPIMock: CocktailAPI {
  var mockCocktails = [
    Cocktail(name: "White Russian", description: "The White Russian is a three-ingredient cocktail based on the erstwhile Black Russian, which turns white on the addition of cream.", ingredients: IngredientsMock.whiteRussian),
    Cocktail(name: "Mojito", description: "The Mojito is traditionally served over ice in a highball glass and often associated with summer.", ingredients: IngredientsMock.mojito)
  ]
  
  func getCocktail(with ingredients: [String]) -> AnyPublisher<[Cocktail], Error> {
    return [mockCocktails].publisher.setFailureType(to: Error.self).eraseToAnyPublisher()
  }
}

enum IngredientsMock {
  static var whiteRussian: [Cocktail.Ingredient] = [
    .init(id: "ice", unit: .piece, amount: 5),
    .init(id: "coffee liqueur", unit: .ml, amount: 50),
    .init(id: "vodka", unit: .ml, amount: 50),
    .init(id: "fresh cream", unit: .ml, amount: 50)
  ]
  
  static var mojito: [Cocktail.Ingredient] = [
    .init(id: "ice", unit: .piece, amount: 5),
    .init(id: "light rum", unit: .ml, amount: 60),
    .init(id: "lime wedges", unit: .piece, amount: 4),
    .init(id: "mint sprigs, or spear", unit: .piece, amount: 12),
    .init(id: "fresh lime juice", unit: .ml, amount: 90)
  ]
}
