import Foundation
import SwiftUI

public struct Cocktail {
  let name: String
  let description: String
  let directions: String
  let imageName: String
  var image: Image {
      Image(imageName)
  }
  let ingredients: Set<Cocktail.Ingredient>
}

extension Cocktail: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.name == rhs.name && lhs.description == rhs.description && lhs.ingredients.count == rhs.ingredients.count
  }
}
extension Cocktail: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(name)
    hasher.combine(description)
  }
}

extension Cocktail {
  struct Ingredient {
    let id: String
    let unit: Unit
    let amount: Int
    
    var name: String { id }
  }
}

extension Cocktail.Ingredient: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.id == rhs.id
  }
}

extension Cocktail.Ingredient: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
