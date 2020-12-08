//
//  ContentView.swift
//  Ethanol
//
//  Created by Ireneusz Sołek on 02/11/2020.
//

import SwiftUI

struct ContentView: View {
  private let dependencyContainer: DependencyContainer

  init(dependencyContainer: DependencyContainer) {
    self.dependencyContainer = dependencyContainer
  }
  
  var body: some View {
    VStack {
    ScrollView {
    IngredientsSelectionView()
      .environment(\.injected, dependencyContainer)
    }
    CollapsedSelectedIngredientsView()
      .environment(\.injected, dependencyContainer)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(dependencyContainer: DependencyContainer.defaultValue)
  }
}
