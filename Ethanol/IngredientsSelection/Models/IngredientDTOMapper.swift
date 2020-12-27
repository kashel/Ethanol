import Foundation

struct IngredientDTOMapper {
  func map(_ ingredient: IngredientDTO) -> Ingredient {
    let groups = ingredient.groups.compactMap{ IngredientGroup(rawValue: $0) }
    return Ingredient(name: ingredient.name, imageName: ingredient.name, groups: Set(groups))
  }
}
