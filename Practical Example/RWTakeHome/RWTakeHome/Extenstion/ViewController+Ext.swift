//
//  ViewController+Ext.swift
//  RWTakeHome
//
//  Created by Nick Nguyen on 10/7/20.
//

import UIKit

extension TutorialViewController {
  
  func reloadDataOnMainThread() {
    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
  }
  
  func showErrorAlertOnMainThread(networkError: LocalizedError) {
    let errorAlert = UIAlertController(localizedError: networkError)
    DispatchQueue.main.async {
      self.present(errorAlert, animated: true, completion: nil)
    }
  }
  
  func getArticlesFromServer() {
    networkService.fetchTutorials(ofType: .article) {  (result) in
      switch result {
      case .success(let tutorials):
        self.articles = tutorials.sorted(by: <)
        self.tutorials = tutorials.sorted(by: <)
        self.reloadDataOnMainThread()
      case .failure(let error):
        self.showErrorAlertOnMainThread(networkError: error)
      }
    }
  }
  
  func getVideosFromServer() {
    networkService.fetchTutorials(ofType: .video) {  (result) in
      switch result {
      case .success(let turorials):
        self.videos = turorials.sorted(by: <)
      case .failure(let error):
        self.showErrorAlertOnMainThread(networkError: error)
      }
    }
  }
}
