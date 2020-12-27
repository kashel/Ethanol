import Foundation

struct IngredientDTO: Decodable {
  let name: String
  let groups: Set<String>
}
