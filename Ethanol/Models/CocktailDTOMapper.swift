//

import Foundation

struct CocktailDTOMapper {
  func map(dto: CocktailDTO) -> Cocktail {
    let lastIndex = dto.image.lastIndex(of: ".")
    let imageName = lastIndex != nil ?  String(dto.image[..<lastIndex!]) : dto.image
    return Cocktail(name: dto.name, description: dto.description, directions: dto.directions.joined(separator: "\n"), imageName: imageName, ingredients: Set(dto.ingredients.map(mapIngredient)))
  }
  
  private func mapIngredient(dto: CocktailDTO.IngredientDTO) -> Cocktail.Ingredient {
    //TODO: fix me
    let unit = Unit(rawValue: dto.measure) ?? .gram
    let amount = Int(dto.quantity) ?? 0
    return Cocktail.Ingredient(id: dto.ingredient.lowercased(), unit: unit, amount: amount)
  }
}
