import Foundation

protocol ActiveSheetInteractor {
  func present(_: Sheet)
}

struct BaseActiveSheetInteractor: ActiveSheetInteractor {
  private var appState: Store<AppState>

  init(appState: Store<AppState>) {
    self.appState = appState
  }
  
  func present(_ sheet: Sheet) {
    appState[\.activeSheet] = nil
    appState[\.activeSheet] = sheet
  }
}
