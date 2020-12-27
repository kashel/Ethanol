import Foundation

enum IngredientGroup: String, CaseIterable {
  case alcohols, fruits, common, herbs, spices
  var name: String { rawValue }
}
