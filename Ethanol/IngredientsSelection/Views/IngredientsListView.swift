import SwiftUI
import Combine

struct IngredientsListView: View {
  let ingredientGroup: IngredientGroup
  @Environment(\.injected) private var injected: DependencyContainer
  @State private var selection: IngredientSelectionObservedModel = .init()
  
  var body: some View {
    let ingredients = selection.ingredients.filter({$0.groups.contains(ingredientGroup) && !$0.isSelected}).sorted { $0.name < $1.name }
    let rows = ingredients.chunked(into: 4)
    ZStack {
      Color.white
        .ignoresSafeArea()
      RadialGradient(gradient: Gradient(colors: [ingredientGroup.color.opacity(0.5), ingredientGroup.color.opacity(0.9)]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, startRadius: 20, endRadius: 380)
        .ignoresSafeArea()
      ScrollView(.vertical) {
        VStack(alignment: .leading) {
          ForEach(rows, id: \.self) { row in
            IngredientGroupRowView(ingredientGroup: ingredientGroup, ingredients: row[...], hasMore: .no)
          }
        }
      }
      .padding()
    }
    .onReceive(update, perform: { selection = $0 })
  }
}

struct IngredientsListView_Previews: PreviewProvider {
  static var previews: some View {
    let group = IngredientGroup.common
    IngredientsListView(ingredientGroup: group)
      .environment(\.injected, DependencyContainer.defaultValue)
  }
}

private extension IngredientsListView {
  var update: AnyPublisher<IngredientSelectionObservedModel, Never> {
    injected.appState.updates(for: \.ingredientSelection)
  }
}


