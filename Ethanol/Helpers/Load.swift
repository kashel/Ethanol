import Foundation

func load<T: Decodable>(_ filename: String, extension: String? = nil) -> T {
    guard let file = Bundle.main.url(forResource: filename, withExtension: `extension`)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
  return load(url: file)
}

func load<T: Decodable>(url file: URL) -> T {
  let data: Data
  do {
      data = try Data(contentsOf: file)
  } catch {
    fatalError("Couldn't load \(file.absoluteString) from main bundle:\n\(error)")
  }

  do {
      let decoder = JSONDecoder()
      return try decoder.decode(T.self, from: data)
  } catch {
      fatalError("Couldn't parse \(file.absoluteString) as \(T.self):\n\(error)")
  }
}
