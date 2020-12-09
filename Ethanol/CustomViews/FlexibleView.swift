import SwiftUI

struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
  let availableWidth: CGFloat
  let data: Data
  let spacing: CGFloat
  let alignment: HorizontalAlignment
  let content: (Data.Element) -> Content
  @State var elementsSize: [Data.Element: CGSize] = [:]
  @State var countedHeight: CGFloat = 0
  

  var body : some View {
    let computedRows = computeRows()
    return VStack(alignment: alignment, spacing: spacing) {
      ForEach(computedRows.rows, id: \.self) { row in
        HStack(spacing: spacing) {
          ForEach(row, id: \.self) { element in
            content(element)
              .readSize { size in
                elementsSize[element] = size
                countedHeight = computedRows.height
              }
          }
        }
      }
    }
    .frame(height: countedHeight)
  }

  func computeRows() -> (rows: [[Data.Element]], height: CGFloat) {
    var rows: [[Data.Element]] = [[]]
    var currentRow = 0
    var remainingWidth = availableWidth
    var height: CGFloat = 0.0
    
    if let first = data.first {
      height += elementsSize[first, default: CGSize(width: availableWidth, height: 1)].height + 2 * spacing
    }
    for element in data {
      let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]
      if remainingWidth - (elementSize.width + spacing) >= 0 {
        rows[currentRow].append(element)
      } else {
        height += elementSize.height + spacing
        currentRow = currentRow + 1
        rows.append([element])
        remainingWidth = availableWidth
      }

      remainingWidth = remainingWidth - (elementSize.width + spacing)
    }
print(height)
    return (rows: rows, height: height)
  }
}
