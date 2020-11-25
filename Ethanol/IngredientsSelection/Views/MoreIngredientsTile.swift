import SwiftUI
import Combine

struct MoreIngredientsTile: View {
  @Environment(\.injected) private var injected: DependencyContainer
  let ingredientGroup: IngredientGroup
  @State private var selection: IngredientSelectionObservedModel = .init()
  @State private var showingIngredientsGroup = false
  
  var body: some View {
    VStack {
      ForEach(0..<2) {
        let row = $0
        HStack {
          ForEach(0..<2) {
              let column = $0
              let index = row*2+column
              let ingredients = selection.ingredients.filter { !$0.isSelected && $0.groups.contains(ingredientGroup) }
              if index < ingredients.count {
                let ingredient = Array(ingredients)[index]
                Image(ingredient.imageName)
                  .resizable()
                  .aspectRatio(1, contentMode: .fit)
                  .padding(1)
                  .cornerRadius(10)
              } else {
                EmptyView()
              }
            }
        }
      }
    }
    .background(Color.green)
    .frame(width: 90, height: 90)
    .cornerRadius(10)
    .onTapGesture {
      showingIngredientsGroup.toggle()
    }
    .onReceive(update, perform: { selection = $0 })
    .sheet(isPresented: $showingIngredientsGroup, content: {
      Text("test")
    })
  }
}

struct MoreIngredientsTile_Previews: PreviewProvider {
  static var previews: some View {
    let group = IngredientGroup.alcohols
    MoreIngredientsTile(ingredientGroup: group)
      .environment(\.injected, DependencyContainer.defaultValue)
  }
}


private extension MoreIngredientsTile {
  var update: AnyPublisher<IngredientSelectionObservedModel, Never> {
      injected.appState.updates(for: \.ingredientSelection)
  }
}
