import Foundation

struct Ingredient: Equatable, Hashable {
  let name: String
  let imageName: String
  let groups: Set<IngredientGroup>
  let isSelected: Bool = false
}
