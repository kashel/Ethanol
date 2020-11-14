
struct DependencyContainer {
  let appState = Store<AppState>(AppState())
  let interactors: Interactors
}

extension DependencyContainer {
  struct Interactors {

  }
}
