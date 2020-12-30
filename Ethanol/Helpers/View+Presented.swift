import Foundation
import SwiftUI

extension View {
    @ViewBuilder func presented(_ shouldPresent: Bool) -> some View {
        switch shouldPresent {
        case true: self
        case false: EmptyView()
        }
    }
}
