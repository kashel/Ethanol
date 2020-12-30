import Combine
import SwiftUI

struct IngredientGroupView: View {
  @Environment(\.injected) private var injected: DependencyContainer
  @State private var selection: IngredientSelectionObservedModel = .init()
  private let screenSize: CGSize = UIScreen.main.bounds.size
  
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
        let rowsParams = calculateRowsParams(availableWidth: screenWidth, ingredientsCount: ingredients.count)
        
        IngredientGroupRowView(ingredientGroup: ingredientGroup, ingredients: ingredients[0..<rowsParams.numberOfItemsFirstRow], hasMore: .no)
        if rowsParams.numberOfRows > 1 {
          let numberOfItemsSecondRow = min(ingredients.count - rowsParams.rowCapacity, rowsParams.rowCapacity) - (rowsParams.hasMore ? 1 : 0)
          let upperBound = rowsParams.numberOfItemsFirstRow + numberOfItemsSecondRow
          IngredientGroupRowView(ingredientGroup: ingredientGroup,
                                 ingredients: ingredients[rowsParams.numberOfItemsFirstRow..<upperBound],
                                 hasMore: rowsParams.hasMore ? .yes(ingredients[upperBound...]) : .no)
        }
      }
    }
    .padding()
    .background(RadialGradient(gradient: Gradient(colors: [.white, backgroundColor]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, startRadius: 10, endRadius: 200))
    .onReceive(update, perform: { selection = $0 })
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
  struct RowsParams {
    let rowCapacity: Int
    let numberOfRows: Int
    let numberOfItemsFirstRow: Int
    let hasMore: Bool
  }
  
  func calculateRowsParams(availableWidth: CGFloat, ingredientsCount: Int) -> RowsParams {
    let rowCapacity = Int(floor(availableWidth / CGFloat(90)))
    let numberOfRows = countNumberOfRows(ingredientsCount: ingredientsCount, rowCapacity: rowCapacity)
    
    return RowsParams(rowCapacity: rowCapacity,
                      numberOfRows: numberOfRows,
                      numberOfItemsFirstRow: (numberOfRows > 1) ? rowCapacity : ingredientsCount,
                      hasMore: (ingredientsCount > rowCapacity * 2))
  }
  
  func countNumberOfRows(ingredientsCount: Int, rowCapacity: Int) -> Int {
    guard rowCapacity > 0 else {
      return 0
    }
    if ingredientsCount <= rowCapacity {
      return 1
    }
    let rowsCount = Int(ceil(CGFloat(ingredientsCount)/CGFloat(rowCapacity)))
    return min(2, max(1, rowsCount))
  }
}

private extension IngredientGroupView {
  var update: AnyPublisher<IngredientSelectionObservedModel, Never> {
    injected.appState.updates(for: \.ingredientSelection)
  }
}
