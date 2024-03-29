import SwiftUI

struct CocktailItemView: View {
  let cocktailResult: CocktailResult
  
  var body: some View {
    ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, content: {
      VStack(alignment: .center) {
        Text(cocktailResult.cocktail.name)
          .font(.title).clipped(antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
        VStack(alignment: .leading) {
          cocktailResult.cocktail.image
            .resizable()
            .scaledToFit()
          HStack {
            VStack(alignment: .leading) {
              ForEach(Array(cocktailResult.cocktail.ingredients), id: \.self) {
                return Text("- \($0.amount) " + $0.unit.displayName + " " + $0.name)
              }
            }
            Spacer()
          }
          .padding([.top, .bottom])
          Spacer()
          Text(cocktailResult.cocktail.directions)
        }
      }
      .padding()
    })
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct CocktailItemView_Preview: PreviewProvider {
  static var previews: some View {
    CocktailItemView(cocktailResult: CocktailResult(cocktail: CocktailMock.mojito, missingIngredients: ["white rum"]))
  }
}
