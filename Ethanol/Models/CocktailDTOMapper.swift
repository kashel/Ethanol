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
    let id = mapIngredientId(dto.ingredient)
    return Cocktail.Ingredient(id: id, unit: unit, amount: amount)
  }
  
  private func mapUnit(_ unit : String) -> Unit {
    let unitRaw = unit.lowercased()
    switch unitRaw {
    case "gram":
      return .gram
    case "ml", "nilliLiters":
      return .ml
    case "pice":
      return .piece
    default:
      return .other(name: unitRaw)
    }
  }
  
  private func mapIngredientId(_ id: String) -> String {
    var name = id.lowercased().components(separatedBy: ",").first!.components(separatedBy: "(").first!
    let trimmingWords = ["for ", "or ", " - "]
    name = trimmingWords.reduce(name) { (name, trimmingWord) -> String in
      if let index = name.range(of: trimmingWord)?.lowerBound {
        let substring = name[..<index]
        return String(substring)
      }
      return name
    }
    name = name.replacingOccurrences(of: "optional: ", with: "")
    return name
  }
}
