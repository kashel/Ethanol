import Foundation

public protocol CocktailLoader {
  func load() -> Set<Cocktail>
}

public struct LocalCocktailLoadere: CocktailLoader {
  private let mapper = CocktailDTOMapper()
  
  public func load() -> Set<Cocktail> {
    let urls = Bundle.main.urls(forResourcesWithExtension: "json", subdirectory: "Drinks")
    guard let cocktails = urls?.map({url -> CocktailDTO in
      Ethanol.load(url: url)
    })
    .map(mapper.map) else {
      return []
    }
    
    return Set(cocktails)
  }
  
  
}
