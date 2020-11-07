import Foundation

struct Cocktail {
  let name: String
  let description: String
  let ingredients: [Cocktail.Ingredient]
}

extension Cocktail {
  struct Ingredient {
    let id: String
    let unit: Unit
    let amount: Int
    
    var name: String { id }
  }
}
