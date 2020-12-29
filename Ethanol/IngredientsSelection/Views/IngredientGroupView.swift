import Combine
import SwiftUI

struct IngredientGroupView: View {
  @Environment(\.injected) private var injected: DependencyContainer
  @State private var selection: IngredientSelectionObservedModel = .init()
  
  let ingredientGroup: IngredientGroup
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text(ingredientGroup.name)
        Spacer()
      }
      let ingredients = selection.ingredients.filter { !$0.isSelected && $0.groups.contains(ingredientGroup) }
      let lineCapacity = 4
      let numberOfLines = countNumberOfLines(ingredientsCount: ingredients.count, lineCapacity: lineCapacity)
      let numberOfItemsFirstLine = (numberOfLines > 1) ? lineCapacity : ingredients.count
      let hasMore = (ingredients.count > lineCapacity * 2)
      
      Text("\(ingredients.count)")
      VStack(alignment: .leading) {
        ingredientsLine(ingredients: ingredients, params: IngredientLineParams(initialIndex: 0, upperBound: numberOfItemsFirstLine))
        if numberOfLines > 1 {
          let numberOfItemsSecondLine = min(ingredients.count - lineCapacity, lineCapacity) - (hasMore ? 1 : 0)
          ingredientsLine(ingredients: ingredients, params: IngredientLineParams(initialIndex: numberOfItemsFirstLine, upperBound: numberOfItemsFirstLine + numberOfItemsSecondLine))
        }
        if hasMore {
          components(for: ingredientGroup)
        }
      }
    }
    .padding()
    .onReceive(update, perform: { selection = $0 })
  }
}

struct IngredientGroupView_Previews: PreviewProvider {
  static var previews: some View {
    let group = IngredientGroup.common
    IngredientGroupView(ingredientGroup: group)
      .environment(\.injected, DependencyContainer.defaultValue)
  }
}

private extension IngredientGroupView {
  struct IngredientLineParams {
    let initialIndex: Int
    let upperBound: Int
  }
  
  func ingredientsLine(ingredients: [Ingredient], params: IngredientLineParams) -> some View {
    HStack {
      ForEach(ingredients[params.initialIndex..<params.upperBound], id: \.self) { currentIngredient in
        IngredientTileView(ingredient: currentIngredient)
          .onTapGesture {
            select(ingredient: currentIngredient)
          }
      }
    }
  }
}

private extension IngredientGroupView {
  private func countNumberOfLines(ingredientsCount: Int, lineCapacity: Int) -> Int {
    if ingredientsCount <= lineCapacity {
      return 1
    }
    let linesCount = Int(ceil(CGFloat(ingredientsCount)/CGFloat(lineCapacity)))
    return min(2, max(1, linesCount))
  }
}

private extension IngredientGroupView {
  func select(ingredient: Ingredient) {
    injected.interactors.ingredientsSelection.select(ingredient: ingredient)
  }
}

private extension IngredientGroupView {
  var update: AnyPublisher<IngredientSelectionObservedModel, Never> {
    injected.appState.updates(for: \.ingredientSelection)
  }
}

private extension IngredientGroupView {
  func components(for group: IngredientGroup) -> some View {
    MoreIngredientsTileView(ingredientGroup: ingredientGroup)
      .environment(\.injected, injected)
  }
}
