//

import Foundation
import Combine

public protocol CocktailAPI {
  func getCocktails(with ingredients: [String]) -> AnyPublisher<[CocktailResult], Error>
}

public protocol LocalCoctailLoader {
  func load() -> [Cocktail]
}

public struct LocalCoctailAPI: CocktailAPI {
  public let loader: LocalCoctailLoader
  private let maxMissingImportance = 2
  
  public init(loader: LocalCoctailLoader) {
    self.loader = loader
  }
  
  public func getCocktails(with ingredients: [String]) -> AnyPublisher<[CocktailResult], Error> {
    return [loader.load().map({CocktailResult(coctail: $0, missingIngredients:[])})].publisher.setFailureType(to: Error.self).eraseToAnyPublisher()
  }
}
