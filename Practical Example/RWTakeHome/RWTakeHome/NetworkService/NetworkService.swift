//
//  Networking.swift
//  RWTakeHome
//
//  Created by Nick Nguyen on 10/7/20.
//

import Foundation

final class NetworkService {
  
  private let jsonDecoder = JSONDecoder()
  
  private var SECRET_KEY: String {
    let env = ProcessInfo.processInfo.environment
    return env["SecretKey"] ?? "NO JSON_BIN.IO SECRET KEY FOUND"
  }
  
  private func generateURLForTutorial(ofType type: TutorialType) -> URLRequest {
    //https://api.jsonbin.io/b/5f7da8e57243cd7e824c263f // video
    //https://api.jsonbin.io/b/5f7da6f065b18913fc5bfe74 // article
    switch type {
    case .article:
      let articleURL = URL(string: "https://api.jsonbin.io/b/5f7da6f065b18913fc5bfe74")!
      return URLRequest(url: articleURL)
    case .video:
      let videoUrl = URL(string: "https://api.jsonbin.io/b/5f7da8e57243cd7e824c263f")!
      return URLRequest(url: videoUrl)
    }
  }
  
  func fetchTutorials(ofType type: TutorialType, completion: @escaping (Result<[Tutorial],NetworkError>) -> Void) {
    
    var urlRequest = generateURLForTutorial(ofType: type)
    urlRequest.setValue(SECRET_KEY, forHTTPHeaderField: "secret-key")
    
    URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      
      if let error = error {
        NSLog(error.localizedDescription)
        completion(.failure(.badURL))
        return
      }
      
      guard let response = response as? HTTPURLResponse, response.isOK else {
        completion(.failure(.badResponse))
        return
      }
      
      guard let data = data else {
        completion(.failure(.unknown))
        return
      }
      
      do {
        let tutorials = try self.jsonDecoder.decode(DataTutorial.self, from: data)
        completion(.success(tutorials.tutorials))
      } catch {
        completion(.failure(.decodeError))
        return
      }
    }.resume()
  }
}

