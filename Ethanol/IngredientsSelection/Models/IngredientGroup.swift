import Foundation
import SwiftUI

enum IngredientGroup: String, CaseIterable {
  case alcohols, fruits, common, herbs, spices, sweets, decors, juices, syrups
  var name: String { rawValue }
  var color: Color {
    switch self {
    case .alcohols:
      return .blue
    case .fruits:
      return .orange
    case .common:
      return .gray
    case .herbs:
      return .green
    case .spices:
      return .red
    case .sweets:
      return .blue
    case .decors:
      return .gray
    case .juices:
      return .yellow
    case .syrups:
      return .purple
    }
  }
}
