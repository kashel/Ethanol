//

import Foundation

struct CocktailDTO: Decodable {
  struct IngredientDTO: Decodable {
    let quantity: String
    let measure: String
    let ingredient: String
  }
  
  let name: String
  let description: String
  let directions: [String]
  let image: String
  let ingredients: [IngredientDTO]
}
