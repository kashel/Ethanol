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
  private let tagsSectionHeight: CGFloat = 80
  
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        Color.gray
        VStack {
          ScrollView {
            IngredientsSelectionView()
              .environment(\.injected, injected)
          }
          .frame(height: geometry.size.height - tagsSectionHeight)
          .background(Color.blue)
          CollapsedSelectedIngredientsView()
            .environment(\.injected, injected)
            .padding()
            .frame(width: geometry.size.width, height: tagsSectionHeight)
        }
      }
      .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environment(\.injected, DependencyContainer.defaultValue)

  }
}

private extension ContentView {
  var update: AnyPublisher<IngredientSelectionObservedModel, Never> {
      injected.appState.updates(for: \.ingredientSelection)
  }
}
