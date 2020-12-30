import Foundation
import XCTest
@testable import Ethanol

class LocalCoctailAPITests: XCTestCase {
  private var sut: LocalCoctailAPI!
  private var loaderMock: LocalCoctailLoaderMock!
  
  override func setUp() {
    super.setUp()
    loaderMock = LocalCoctailLoaderMock()
    loaderMock.availableCoctails = [CoctailMock.A, CoctailMock.B, CoctailMock.D, CoctailMock.AB, CoctailMock.ABC]
    sut = LocalCoctailAPI(loader: loaderMock)
  }
  
  func test_whenGetCoctailsIsCalled_sutCallsLoaderToFetchCoctailsToMemory() {
    XCTAssertFalse(loaderMock.loadCalled)
    let _ = sut.getCocktails(with: []).sink(receiveCompletion: {_ in }, receiveValue: {_ in })
    XCTAssertTrue(loaderMock.loadCalled)
  }
  
  func test_cocktailWithTheMostOfCommonIngredients_isReturnedFirst() {
    var cocktails = [CocktailResult]()
    let _ = sut.getCocktails(with: ["A", "B", "C"]).sink(receiveCompletion: {_ in }, receiveValue: { results in
      cocktails = results
    })
    XCTAssertEqual(cocktails.first?.coctail.name, "ABC")
  }
  
  func test_cocktailWithAllIngredientsMatched_doesNotHaveAnyMissingIngredients() {
    var cocktails = [CocktailResult]()
    let _ = sut.getCocktails(with: ["A", "B", "C"]).sink(receiveCompletion: {_ in }, receiveValue: { results in
      cocktails = results
    })
    XCTAssertEqual(cocktails.first?.missingIngredients, [])
  }
  
  func test_cocktailWithOneMissingIngredient_isReturnedSecond() {
    var cocktails = [CocktailResult]()
    let _ = sut.getCocktails(with: ["A", "B", "C"]).sink(receiveCompletion: {_ in }, receiveValue: { results in
      cocktails = results
    })
    cocktails = Array(cocktails.dropFirst())
    XCTAssertEqual(cocktails.first?.coctail.name, "AB")
    XCTAssertEqual(cocktails.first?.missingIngredients.map{ $0.name }, ["C"])
  }
  
  func test_cocktailWithMissingIngredientsWithAcceptedRange_isPresentInResponse() {
    var cocktails = [CocktailResult]()
    let _ = sut.getCocktails(with: ["A", "B", "C"]).sink(receiveCompletion: {_ in }, receiveValue: { results in
      cocktails = results
    })
    cocktails = Array(cocktails.dropFirst())
    XCTAssertTrue(cocktails.map{ $0.coctail.name }.contains("A"))
    XCTAssertTrue(cocktails.map{ $0.coctail.name }.contains("B"))
  }
  
  func test_cocktailWithMissingIngredientsAboveAcceptedRange_isNotPresentInResponse() {
    var cocktails = [CocktailResult]()
    let _ = sut.getCocktails(with: ["A", "B", "C"]).sink(receiveCompletion: {_ in }, receiveValue: { results in
      cocktails = results
    })
    cocktails = Array(cocktails.dropFirst())
    XCTAssertFalse(cocktails.map{ $0.coctail.name }.contains("D"))
  }
}
