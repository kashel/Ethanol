//
//  EthanolApp.swift
//  Ethanol
//
//  Created by Ireneusz Sołek on 02/11/2020.
//

import SwiftUI

@main
struct EthanolApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView(dependencyContainer: makeDependencyContainer)
    }
  }
}

private extension EthanolApp {
  var makeDependencyContainer: DependencyContainer {
    DependencyContainer(interactors: Interactors())
  }
}
