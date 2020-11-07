import Foundation

enum IngredientGroup: String, CaseIterable {
  case alcohols, fruits, common
  var name: String { rawValue }
}
