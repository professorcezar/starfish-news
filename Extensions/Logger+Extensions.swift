import Foundation
import os.log

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    /// Logs the view cycles like viewDidLoad.
    static let provider = Logger(subsystem: subsystem, category: "provider")
    static let appcycle = Logger(subsystem: subsystem, category: "appcycle")
}
