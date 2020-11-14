import SwiftUI

struct DependencyContainer {
  let appState: Store<AppState>
  let interactors: Interactors
}

extension DependencyContainer: EnvironmentKey {
  static var defaultValue: DependencyContainer {
    let appState = Store<AppState>(AppState())
    return DependencyContainer(appState: appState, interactors: Interactors(appState: appState))
  }
}

extension EnvironmentValues {
  var injected: DependencyContainer {
    get { self[DependencyContainer.self] }
    set { self[DependencyContainer.self] = newValue }
  }
}
