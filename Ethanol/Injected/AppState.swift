import Combine

struct AppState {
  var selection = Selection()
  struct Selection: Equatable {
    var test1: String = "test1"
    var test2: String = "test2"
  }
}
