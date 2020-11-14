import SwiftUI

struct DependencyContainer {
  let appState = Store<AppState>(AppState())
  let interactors: Interactors
}

extension DependencyContainer: EnvironmentKey {
  static var defaultValue: DependencyContainer {
    DependencyContainer(interactors: Interactors())
  }
}

extension EnvironmentValues {
  var injected: DependencyContainer {
    get { self[DependencyContainer.self] }
    set { self[DependencyContainer.self] = newValue }
  }
}
