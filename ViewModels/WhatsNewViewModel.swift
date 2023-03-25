import SwiftUI

class WhatsNewViewModel: ObservableObject {
    @Published var features = [String]()
    
    init() {
        self.features = ["New feature 1",
                         "New feature 2",
                         "New feature 3",
                         "New feature 4",
                         "New feature 5",
                         "New feature 6"]
    }
}
