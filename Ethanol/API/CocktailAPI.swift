//

import Foundation
import Combine

public protocol CocktailAPI {
  func getCocktails(with ingredients: [String]) -> AnyPublisher<[CocktailResult], Error>
}

public protocol LocalCocktailLoader {
  func load() -> [Cocktail]
}

public struct LocalCocktailAPI: CocktailAPI {
  public let loader: LocalCocktailLoader
  private let maxMissingImportance = 2
  
  public init(loader: LocalCocktailLoader) {
    self.loader = loader
  }
  
  public func getCocktails(with ingredients: [String]) -> AnyPublisher<[CocktailResult], Error> {
    return [loader.load().map({CocktailResult(cocktail: $0, missingIngredients:[])})].publisher.setFailureType(to: Error.self).eraseToAnyPublisher()
  }
}
