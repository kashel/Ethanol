import Foundation
@testable import Ethanol

enum CocktailMock {
  static var whiteRussian: Cocktail = {
    return Cocktail(name: "White Russian", description: "The White Russian is a three-ingredient cocktail based on the erstwhile Black Russian, which turns white on the addition of cream.", directions: """
      Pour coffee liqueur and vodka into an Old Fashioned glass filled with ice.
      Float fresh cream on top and stir slowly.
      """, imageName: "whiterussian", ingredients: IngredientsMock.whiteRussian)
  }()
  static var mojito: Cocktail = {
    return Cocktail(name: "Mojito", description: "The Mojito is traditionally served over ice in a highball glass and often associated with summer.", directions: """
      Place ice, rum, eight broken up mint sprigs, lime juice, and sugar in a beverage shaker.
      Shake well and serve over ice in a high ball glass. Top off each glass with a splash of club soda
      Garnish each with a slice of lime and a sprig of mint.
      """, imageName: "mojito", ingredients: IngredientsMock.mojito)
  }()
  
  static var A: Cocktail {
    return Cocktail(name: "A", description: "", directions: "", imageName: "", ingredients: [.init(id: "A", unit: .gram, amount: 1)])
  }
  static var B: Cocktail {
    return Cocktail(name: "B", description: "", directions: "", imageName: "", ingredients: [.init(id: "B", unit: .gram, amount: 1)])
  }
  static var D: Cocktail {
    return Cocktail(name: "D", description: "", directions: "", imageName: "", ingredients: [.init(id: "D", unit: .gram, amount: 1)])
  }
  static var AB: Cocktail {
    return Cocktail(name: "AB", description: "", directions: "", imageName: "", ingredients: [.init(id: "A", unit: .gram, amount: 1),
                                                                              .init(id: "B", unit: .gram, amount: 1)])
  }
  static var ABC: Cocktail {
    return Cocktail(name: "ABC", description: "", directions: "", imageName: "", ingredients: [.init(id: "A", unit: .gram, amount: 1),
                                                                               .init(id: "B", unit: .gram, amount: 1),
                                                                               .init(id: "C", unit: .gram, amount: 1)])
  }
}

enum IngredientsMock {
  static var whiteRussian: Set<Cocktail.Ingredient> = [
    .init(id: "ice", unit: .piece, amount: 5),
    .init(id: "coffee liqueur", unit: .ml, amount: 50),
    .init(id: "vodka", unit: .ml, amount: 50),
    .init(id: "fresh cream", unit: .ml, amount: 50)
  ]
  
  static var mojito: Set<Cocktail.Ingredient> = [
    .init(id: "ice", unit: .piece, amount: 5),
    .init(id: "white rum", unit: .ml, amount: 60),
    .init(id: "lime wedges", unit: .piece, amount: 4),
    .init(id: "mint", unit: .piece, amount: 12),
    .init(id: "fresh lime juice", unit: .ml, amount: 90)
  ]
}

class LocalCocktailLoaderMock: CocktailLoader {
  var availableCocktails: Set<Cocktail> = []
  
  var loadCalled = false
  func load() -> Set<Cocktail> {
    loadCalled = true
    return availableCocktails
  }
}
