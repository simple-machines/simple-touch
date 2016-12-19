//
//  SimpleTouch.swift
//  SimpleTouch
//
//  Created by Hamish Rickerby on 19/10/2015.
//  Copyright © 2015 Simple Machines. All rights reserved.
//

import LocalAuthentication

public typealias TouchIDPresenterCallback = (TouchIDResponse) -> Void

public struct SimpleTouch {

  public static var hardwareSupportsTouchID: TouchIDResponse {
    let response = evaluateTouchIDPolicy
    guard response != TouchIDResponse.error(.touchIDNotAvailable) else {
      return response
    }
    return .success
  }
  
  public static var isTouchIDEnabled: TouchIDResponse {
    return evaluateTouchIDPolicy
  }
  
  fileprivate static var evaluateTouchIDPolicy: TouchIDResponse {
    let context = LAContext()
    var error: NSError?
    guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
      return TouchIDResponse.error(TouchIDError.createError(error))
    }
    return TouchIDResponse.success
  }
  
  public static func presentTouchID(_ reason: String, fallbackTitle: String, callback: @escaping TouchIDPresenterCallback) {
    let context = LAContext()
    context.localizedFallbackTitle = fallbackTitle
    context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { _, error in
      guard error == nil else {
        DispatchQueue.main.async(execute: {
          callback(.error(TouchIDError.createError(error as NSError?)))
        })
        return
      }
      DispatchQueue.main.async(execute: {
        callback(.success)
      })
    }
  }

}
