//

import Foundation
import Combine

public protocol CocktailAPI {
  func getCocktails(with ingredients: Set<String>) -> AnyPublisher<[CocktailResult], Error>
}

public struct LocalCocktailAPI: CocktailAPI {
  public let loader: CocktailLoader
  private let maxMissingImportance = 3
  
  public init(loader: CocktailLoader) {
    self.loader = loader
  }
  
  public func getCocktails(with searchIngredients: Set<String>) -> AnyPublisher<[CocktailResult], Error> {
    let matchingCocktails = loader.load().map { cocktail -> CocktailResult in
      let cocktailIngredients = Set(cocktail.ingredients.map({ $0.name }))
      let missingIngredients = cocktailIngredients.subtracting(searchIngredients)
      return CocktailResult(cocktail: cocktail, missingIngredients: missingIngredients)
    }.filter { (result) -> Bool in
      //TODO: count importance
      result.missingIngredients.count <= maxMissingImportance
    }.sorted { (lhs, rhs) -> Bool in
      lhs.missingIngredients.count < rhs.missingIngredients.count
    }
    
    return [matchingCocktails].publisher.setFailureType(to: Error.self).eraseToAnyPublisher()
  }
}
