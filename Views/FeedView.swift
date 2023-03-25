import Foundation
import os.log
import SwiftUI
import Combine
import SBPAsyncImage

struct FeedView: View {
    @StateObject var model = FeedViewModel()
    
    var body: some View {
        if case .success(let articles) = model.state {
            SuccessView(articles: articles)
        } else if case .failure(let error) = model.state {
            ErrorView(error: error)
        } else if case .loading = model.state {
            LoadingView()
        } else {
            SuccessView(articles: [Article]())
        }
    }
}

fileprivate struct ErrorView: View {
    let error: Error
    
    var body: some View {
        VStack {
            Text("An error has occurred!")
                .font(.title)
                .padding(.bottom)
            Text(error.localizedDescription)
                .font(.headline)
            Spacer()
        }
        .padding()
        .cornerRadius(16)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Dismiss") {
                }
            }
        }        
    }
}

fileprivate struct LoadingView: View {
    var body: some View {
        ProgressView("Loading")
    }
}

fileprivate struct SuccessView: View {
    let articles: [Article]
    
    var body: some View {
        ScrollView {
            ForEach(articles) { article in
                CardView(article)
            }
        }
        .navigationTitle("Articles")
    }
}

fileprivate struct CardView: View {
    private let article: Article
    @State private var showSafari: Bool = false
    
    init(_ article: Article) {
        self.article = article
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            // Image
            BackportAsyncImage(url: article.imageURL) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ZStack (alignment: .center) {
                    Color.black.opacity(0.2)
                    Image(systemName: "photo")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, idealHeight: 200)
                }
            }
            
            // Title
            Text(article.title)
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.leading)
            
            // Description
            Text(article.description)
                .foregroundColor(.secondary)
                .padding(.leading)
        }
        .padding(.bottom, 10)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal, 10)
        .onTapGesture { showSafari.toggle() }
        .fullScreenCover(isPresented: $showSafari) {
            SafariWrapperView(url: article.articleURL)
        }
    }
}
