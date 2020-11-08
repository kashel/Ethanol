import Foundation

protocol IngredientGroupInteractor {
  func selectIngredient(_: Ingredient)
}

struct LocalIngredientGroupInteractor: IngredientGroupInteractor {
  private let ingredientsRepository: IngredientsRepository
  
  func selectIngredient(_ ingredient: Ingredient) {
    ingredientsRepository.selectIngredient(ingredient)
  }
}
