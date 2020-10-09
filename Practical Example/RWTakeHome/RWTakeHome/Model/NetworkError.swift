//
//  NetworkError.swift
//  RWTakeHome
//
//  Created by Nick Nguyen on 10/9/20.
//

import Foundation

enum NetworkError: Error {
  case badResponse
  case badURL
  case unknown
  case decodeError
}

extension NetworkError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .badResponse:
      return "Bad response from server. Please go back"
    case .badURL:
      return "Bad URL from server. Please go back"
    case .unknown:
      return "Unknown error occured. Please go back"
    case .decodeError:
      return "Unexpected problems. Please go back"
    }
  }
}
