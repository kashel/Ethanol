import Combine
import SwiftUI

struct IngredientGroupView: View {
  @Environment(\.injected) private var injected: DependencyContainer
  @State private var selection: IngredientSelectionObservedModel = .init()
  @State var orientation = UIDevice.current.orientation
  private let screenSize: CGSize = UIScreen.main.bounds.size

  let orientationChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
      .makeConnectable()
      .autoconnect()
  
  let ingredientGroup: IngredientGroup
  let backgroundColor: Color
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text(ingredientGroup.name)
          .foregroundColor(.white)
        Spacer()
      }      
      VStack(alignment: .leading) {
        let ingredients = selection.ingredients.filter { !$0.isSelected && $0.groups.contains(ingredientGroup) }
        //support portrait mode only currenty
        let screenWidth = screenSize.width
        let lineCapacity = Int(floor(screenWidth / CGFloat(90)))
        let numberOfLines = countNumberOfLines(ingredientsCount: ingredients.count, lineCapacity: lineCapacity)
        let numberOfItemsFirstLine = (numberOfLines > 1) ? lineCapacity : ingredients.count
        let hasMore = (ingredients.count > lineCapacity * 2)
        
        ingredientsLine(ingredients: ingredients,
                        params: IngredientLineParams(initialIndex: 0, upperBound: numberOfItemsFirstLine),
                        hasMore: false,
                        ingredientGroup: ingredientGroup)
        if numberOfLines > 1 {
          let numberOfItemsSecondLine = min(ingredients.count - lineCapacity, lineCapacity) - (hasMore ? 1 : 0)
          ingredientsLine(ingredients: ingredients,
                          params: IngredientLineParams(initialIndex: numberOfItemsFirstLine, upperBound: numberOfItemsFirstLine + numberOfItemsSecondLine),
                          hasMore: hasMore,
                          ingredientGroup: ingredientGroup)
        }
      }
    }
    .padding()
    .background(RadialGradient(gradient: Gradient(colors: [.white, backgroundColor]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, startRadius: 10, endRadius: 200))
    .onReceive(update, perform: { selection = $0 })
    .onReceive(orientationChanged) { _ in
                self.orientation = UIDevice.current.orientation
    }
  }
}

struct IngredientGroupView_Previews: PreviewProvider {
  static var previews: some View {
    let group = IngredientGroup.common
    IngredientGroupView(ingredientGroup: group, backgroundColor: Color.blue)
      .environment(\.injected, DependencyContainer.defaultValue)
  }
}

private extension IngredientGroupView {
  struct IngredientLineParams {
    let initialIndex: Int
    let upperBound: Int
  }
  
  func ingredientsLine(ingredients: [Ingredient], params: IngredientLineParams, hasMore: Bool, ingredientGroup: IngredientGroup) -> some View {
    HStack {
      ForEach(ingredients[params.initialIndex..<params.upperBound], id: \.self) { currentIngredient in
        IngredientTileView(ingredient: currentIngredient)
          .onTapGesture {
            select(ingredient: currentIngredient)
          }
      }
      if hasMore {
        components(for: ingredientGroup)
      }
    }
  }
}

private extension IngredientGroupView {
  private func countNumberOfLines(ingredientsCount: Int, lineCapacity: Int) -> Int {
    guard lineCapacity > 0 else {
      return 0
    }
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
