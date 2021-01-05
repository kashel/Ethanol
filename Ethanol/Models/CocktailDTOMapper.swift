//

import Foundation

struct CocktailDTOMapper {
  func map(dto: CocktailDTO) -> Cocktail {
    let lastIndex = dto.image.lastIndex(of: ".")
    let imageName = lastIndex != nil ?  String(dto.image[..<lastIndex!]) : dto.image
    return Cocktail(name: dto.name, description: dto.description, directions: dto.directions.joined(separator: "\n"), imageName: imageName, ingredients: Set(dto.ingredients.map(mapIngredient)))
  }
  
  private func mapIngredient(dto: CocktailDTO.IngredientDTO) -> Cocktail.Ingredient {

    let unit = mapUnit(dto.measure)
    let amount = Int(dto.quantity) ?? 0
    return Cocktail.Ingredient(id: dto.ingredient.lowercased(), unit: unit, amount: amount)
  }
  
  private func mapUnit(_ unit : String) -> Unit {
    let unitRaw = unit.lowercased()
    switch unitRaw {
    case "gram":
      return .gram
    case "ml":
      return .ml
    case "pice":
      return .piece
    default:
      return .other(name: unitRaw)
    }
  }
}
