import Foundation

enum IngredientGroup: String, CaseIterable {
  case alkohols, fruits, common
  var name: String { rawValue }
}
