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
  private let tagsSectionHeight: CGFloat = 120
  @State private var activeSheet: Sheet?
  @State private var showSheet: Bool = false
  
  var body: some View {
      ZStack {
        Color.clear
        VStack {
          ScrollView {
            IngredientsSelectionView()
              .environment(\.injected, injected)
          }
        }.ignoresSafeArea()
        HStack {
          VStack {
            Spacer()
              CollapsedSelectedIngredientsView()
                .environment(\.injected, injected)
                .frame(height: tagsSectionHeight)
                .cornerRadius(30)
          }
        }
        .padding()
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
