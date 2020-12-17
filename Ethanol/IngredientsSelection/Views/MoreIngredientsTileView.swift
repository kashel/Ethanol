import SwiftUI
import Combine

struct MoreIngredientsTileView: View {
  @Environment(\.injected) private var injected: DependencyContainer
  let ingredientGroup: IngredientGroup
  @State private var selection: IngredientSelectionObservedModel = .init()
  
  @State private var tileSize = TileSize()
  
  var body: some View {
    ZStack {
      VStack(spacing: tileSize.spacing) {
        ForEach(0..<numberOfRows) {
          let row = $0
          HStack(spacing: tileSize.spacing) {
            ForEach(0..<2) {
              let column = $0
              let index = row*2+column
              if index < ingredients.count {
                let ingredient = Array(ingredients)[index]
                Image(ingredient.imageName)
                  .resizable()
                  .aspectRatio(1, contentMode: .fit)
                  .background(Color.red)
                  .frame(width: tileSize.smallEdge, height: tileSize.smallEdge)
                  .cornerRadius(tileSize.smallCornerRadius)
              } else {
                EmptyView()
              }
            }
          }
        }
      }
    }
    .padding(tileSize.spacing)
    .frame(width: tileSize.edge, height: tileSize.edge)
    .background(Color.green)
    .cornerRadius(tileSize.cornerRadius)
    .onTapGesture {
      injected.interactors.activeSheet.present(.moreIngredients(group: ingredientGroup))
    }
    .onReceive(update, perform: { selection = $0 })
  }
}

struct MoreIngredientsTile_Previews: PreviewProvider {
  static var previews: some View {
    let group = IngredientGroup.common
    MoreIngredientsTileView(ingredientGroup: group)
      .environment(\.injected, DependencyContainer.defaultValue)
  }
}

private extension MoreIngredientsTileView {
  var ingredients: [Ingredient] {
    selection.ingredients.filter {
      !$0.isSelected && $0.groups.contains(ingredientGroup)
    }
  }
  
  var numberOfRows: Int { ingredients.count > 2 ? 2 : 1 }
}

private extension MoreIngredientsTileView {
  var update: AnyPublisher<IngredientSelectionObservedModel, Never> {
    injected.appState.updates(for: \.ingredientSelection)
  }
}
