//
//  HTTPURLResponse+Ext.swift
//  RWTakeHome
//
//  Created by Nick Nguyen on 10/7/20.
//

import UIKit

extension HTTPURLResponse {
  var isOK: Bool {
    return  (200...299).contains(statusCode)
  }
}

