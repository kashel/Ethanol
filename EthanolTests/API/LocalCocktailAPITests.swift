import Foundation
import XCTest
@testable import Ethanol

class LocalCocktailAPITests: XCTestCase {
  private var sut: LocalCocktailAPI!
  private var loaderMock: LocalCocktailLoaderMock!
  
  override func setUp() {
    super.setUp()
    loaderMock = LocalCocktailLoaderMock()
    loaderMock.availableCocktails = [CocktailMock.A, CocktailMock.B, CocktailMock.D, CocktailMock.AB, CocktailMock.ABC]
    sut = LocalCocktailAPI(loader: loaderMock)
  }
  
  func test_whenGetCocktailsIsCalled_sutCallsLoaderToFetchCocktailsToMemory() {
    XCTAssertFalse(loaderMock.loadCalled)
    let _ = sut.getCocktails(with: []).sink(receiveCompletion: {_ in }, receiveValue: {_ in })
    XCTAssertTrue(loaderMock.loadCalled)
  }
  
  func test_cocktailWithTheMostOfCommonIngredients_isReturnedFirst() {
    var cocktails = [CocktailResult]()
    let _ = sut.getCocktails(with: ["A", "B", "C"]).sink(receiveCompletion: {_ in }, receiveValue: { results in
      cocktails = results
    })
    XCTAssertEqual(cocktails.first?.cocktail.name, "ABC")
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
    XCTAssertEqual(cocktails.first?.cocktail.name, "AB")
    XCTAssertEqual(cocktails.first?.missingIngredients.map{ $0.name }, ["C"])
  }
  
  func test_cocktailWithMissingIngredientsWithAcceptedRange_isPresentInResponse() {
    var cocktails = [CocktailResult]()
    let _ = sut.getCocktails(with: ["A", "B", "C"]).sink(receiveCompletion: {_ in }, receiveValue: { results in
      cocktails = results
    })
    cocktails = Array(cocktails.dropFirst())
    XCTAssertTrue(cocktails.map{ $0.cocktail.name }.contains("A"))
    XCTAssertTrue(cocktails.map{ $0.cocktail.name }.contains("B"))
  }
  
  func test_cocktailWithMissingIngredientsAboveAcceptedRange_isNotPresentInResponse() {
    var cocktails = [CocktailResult]()
    let _ = sut.getCocktails(with: ["A", "B", "C"]).sink(receiveCompletion: {_ in }, receiveValue: { results in
      cocktails = results
    })
    cocktails = Array(cocktails.dropFirst())
    XCTAssertFalse(cocktails.map{ $0.cocktail.name }.contains("D"))
  }
}
