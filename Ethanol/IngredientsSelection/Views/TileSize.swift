import UIKit

struct TileSize {
  private let cornerRatio: CGFloat = 0.15
  var edge: CGFloat
  var cornerRadius: CGFloat { cornerRatio * edge }
  var smallEdge: CGFloat { 0.4 * edge }
  var smallCornerRadius: CGFloat { cornerRatio * smallEdge }
  var spacing: CGFloat { (edge - 2 * smallEdge) / 3 }
  
  init(edge: CGFloat = 90) {
    self.edge = edge
  }
}
