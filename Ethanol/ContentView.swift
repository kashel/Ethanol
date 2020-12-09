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
//  @State private var tagsSectionHeight: CGFloat = 0.0
  
  var body: some View {
    GeometryReader { geometry in
    VStack {
      ScrollView {
        IngredientsSelectionView()
          .environment(\.injected, injected)
      }
//      .frame(height: geometry.size.height - tagsSectionHeight)
      collapsedSelectedIngredientsView
        .fixedSize(horizontal: false, vertical: true)
//        .frame(height: tagsSectionHeight)
    }
    }
//    .onReceive(update, perform: { _ in
//      collapsedSelectedIngredientsView
//        .fixedSize(horizontal: false, vertical: true)
//        .readSize { (size) in
//        self.tagsSectionHeight = size.height
//      }
//
//    })

  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environment(\.injected, DependencyContainer.defaultValue)

  }
}

private extension ContentView {
  var collapsedSelectedIngredientsView: some View {
    return CollapsedSelectedIngredientsView()
      .environment(\.injected, injected)
      .background(Color.red)
  }
}
private extension ContentView {
  var update: AnyPublisher<IngredientSelectionObservedModel, Never> {
      injected.appState.updates(for: \.ingredientSelection)
  }
}
