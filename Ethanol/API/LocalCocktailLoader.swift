import Foundation

public protocol CocktailLoader {
  func load() -> Set<Cocktail>
}

public struct LocalCocktailLoadere: CocktailLoader {
  public func load() -> Set<Cocktail> {
    let urls = Bundle.main.urls(forResourcesWithExtension: "json", subdirectory: "Drinks")
    urls?.map({ $0.absoluteString }).forEach({print($0)})
    
    let mock = LocalCocktailLoaderMock()
    mock.availableCocktails = [CocktailMock.mojito, CocktailMock.whiteRussian]
    return mock.load()
  }
  
  
}
