//

import SwiftUI
import Combine

struct IngredientsSelectionView: View {
  @Environment(\.injected) private var injected: DependencyContainer
  @State private var selection: IngredientSelectionObservedModel = .init()
  
  var body: some View {
    let unsulectedIngredientsGroups = selection.ingredients.filter({ !$0.isSelected }).flatMap({ $0.groups })
    var allCases = IngredientGroup.allCases.filter({ group in
      unsulectedIngredientsGroups.contains(group)
    })
    
    let first = allCases.first
    let last = allCases.count > 1 ? allCases.last : nil
    allCases = allCases.dropFirst().dropLast()
    
    return VStack {
      ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
        VStack(spacing: 0) {
          if let first = first {
            components(for: first, heightPadding: 30)
          }
          ForEach(allCases, id: \.self) { ingredientGroup in
            components(for: ingredientGroup)
          }
          if let last = last {
            components(for: last, bottomPadding: 170)
          }
        }
      })
    }
    .onReceive(update, perform: { selection = $0 })
  }
}

struct IngredientsSelectionView_Previews: PreviewProvider {
  static var previews: some View {
    IngredientsSelectionView()
  }
}

private extension IngredientsSelectionView {
  func components(for group: IngredientGroup, heightPadding: CGFloat = 0, bottomPadding: CGFloat = 0) -> some View {
    IngredientGroupView(ingredientGroup: group, backgroundColor: group.color, heightPadding: heightPadding, bottomPadding: bottomPadding)
      .environment(\.injected, injected)
  }
}

private extension IngredientsSelectionView {
  var update: AnyPublisher<IngredientSelectionObservedModel, Never> {
    injected.appState.updates(for: \.ingredientSelection)
  }
}
