import Foundation

struct Ingredient: Equatable, Hashable {
  let name: String
  let imageName: String
  let groups: Set<IngredientGroup>
  var isSelected: Bool = false
  let importance: Int = 1
}
