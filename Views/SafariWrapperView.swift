import Foundation
import SwiftUI
import SafariServices

struct SafariWrapperView: UIViewControllerRepresentable {
    let url: URL?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
        if let url {
            return SFSafariViewController(url: url)
        } else {
            return SFSafariViewController(url: URL(string: "https://example.com")!)
        }
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariWrapperView>) {
        return
    }
}

