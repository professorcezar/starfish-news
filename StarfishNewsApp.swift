import SwiftUI
import os.log

@main
struct StarfishNewsApp: App {
    @State private var showWhatsNew = false
    
    init() {
        Logger.appcycle.info("Starting app...")
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                FeedView()
            }
        }
    }
}
