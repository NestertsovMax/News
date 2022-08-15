//
//  APICaller.swift
//  News
//
//  Created by M1 on 15.08.2022.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let topHeadlinesURL = URL(string:
        "https://newsapi.org/v2/everything?q=Apple&from=2022-08-15&sortBy=popularity&apiKey=3971a73d5ba548be81c3918ad255ace3")
    }
    private init() {}
    
    public func getTopStories(complection: @escaping(Result<[Article], Error>) -> Void) {
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                complection(.failure(error))
            }
            else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("Articles: \(result.articles.count)")
                    complection(.success(result.articles))
                }
                catch {
                    complection(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}

struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}

struct Source: Codable {
    let name: String
}
