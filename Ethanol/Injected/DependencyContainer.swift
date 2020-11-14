import SwiftUI

struct DependencyContainer {
  let appState = Store<AppState>(AppState())
  lazy var interactors = Interactors(appState: appState)
}

extension DependencyContainer: EnvironmentKey {
  static var defaultValue: DependencyContainer {
    DependencyContainer()
  }
}

extension EnvironmentValues {
  var injected: DependencyContainer {
    get { self[DependencyContainer.self] }
    set { self[DependencyContainer.self] = newValue }
  }
}
