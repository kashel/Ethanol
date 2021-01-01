//
//  ContentView.swift
//  Ethanol
//
//  Created by Ireneusz Sołek on 02/11/2020.
//

import SwiftUI
import Combine

struct ContentView: View {
  @Environment(\.injected) private var injected: DependencyContainer
  private let tagsSectionHeight: CGFloat = 110
  @State private var activeSheet: Sheet?
  @State private var showSheet: Bool = false
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        Color.clear
        VStack {
          ScrollView {
            IngredientsSelectionView()
              .environment(\.injected, injected)
          }
          .frame(height: geometry.size.height - tagsSectionHeight)
          CollapsedSelectedIngredientsView()
            .environment(\.injected, injected)
            .padding()
            .frame(width: geometry.size.width, height: tagsSectionHeight)
        }
        .frame(width: geometry.size.width)
      }
      .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
    }
    .onReceive(update, perform: { activeSheet = $0 })
    .sheet(item: $activeSheet, content: { sheet in
      switch sheet {
      case .moreIngredients(let ingredientGroup):
        IngredientsListView(ingredientGroup: ingredientGroup)
      case .selectedIngredients:
        ExpandedSelectedIngredientsView().environment(\.injected, injected)
      case .filteredCocktails:
        CocktailsListView().environment(\.injected, injected)
      }
    })
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environment(\.injected, DependencyContainer.defaultValue)
    
  }
}

private extension ContentView {
  var update: AnyPublisher<Sheet?, Never> {
    injected.appState.updates(for: \.activeSheet)
  }
}
