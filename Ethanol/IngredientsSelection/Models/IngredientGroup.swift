import Foundation

enum IngredientGroup: String, CaseIterable {
  case alcohols, fruits, common, herbs, spices, sweets, decors, juices, syrups
  var name: String { rawValue }
}
