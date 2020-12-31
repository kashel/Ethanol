import SwiftUI

struct DependencyContainer {
  let appState: Store<AppState>
  let interactors: Interactors
}

extension DependencyContainer: EnvironmentKey {
  static var defaultValue: DependencyContainer {
    let state = AppState()
    let appState = Store<AppState>(state)
    let interactors = Interactors(appState: appState)
    return DependencyContainer(appState: appState, interactors: interactors)
  }
}

extension EnvironmentValues {
  var injected: DependencyContainer {
    get { self[DependencyContainer.self] }
    set { self[DependencyContainer.self] = newValue }
  }
}
