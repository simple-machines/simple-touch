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
    guard response != TouchIDResponse.Error(.TouchIDNotAvailable) else {
      return response
    }
    return .Success
  }
  
  public static var isTouchIDEnabled: TouchIDResponse {
    return evaluateTouchIDPolicy
  }
  
  private static var evaluateTouchIDPolicy: TouchIDResponse {
    let context = LAContext()
    var error: NSError?
    guard context.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: &error) else {
      return TouchIDResponse.Error(TouchIDError.createError(error))
    }
    return TouchIDResponse.Success
  }
  
  public static func presentTouchID(reason: String, fallbackTitle: String, callback: TouchIDPresenterCallback) {
    let context = LAContext()
    context.localizedFallbackTitle = fallbackTitle
    context.evaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { _, error in
      guard error == nil else {
        dispatch_async(dispatch_get_main_queue(), {
          callback(.Error(TouchIDError.createError(error)))
        })
        return
      }
      dispatch_async(dispatch_get_main_queue(), {
        callback(.Success)
      })
    }
  }

}
