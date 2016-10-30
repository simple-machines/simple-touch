//
//  TouchIDError.swift
//  SimpleTouch
//
//  Created by Hamish Rickerby on 19/10/2015.
//  Copyright © 2015 Simple Machines. All rights reserved.
//

import LocalAuthentication

// Wrapper for LAError as an ErrorType + 2 new errors, that _should_ never throw
public enum TouchIDError: Error {
  // An error we may get when we don't have a real error, but policy evaluation fails.
  // Will hopefully never happen.
  case undeterminedState
  
  // Error when the code is not a defined LAError type.
  // Will hopefully never happen.
  case unknownError(NSError)
  
  // LAError cases
  case appCancel
  case authenticationFailed
  case invalidContext
  case passcodeNotSet
  case systemCancel
  case touchIDLockout
  case touchIDNotAvailable
  case touchIDNotEnrolled
  case userCancel
  case userFallback
  
  internal static func createError(_ error: NSError?) -> TouchIDError {
    guard let tidError = error else {
      return TouchIDError.undeterminedState
    }
    
    guard let type: LAError.Code = tidError.code.toEnum() else {
      return TouchIDError.unknownError(tidError)
    }
    
    switch type {
    case .appCancel:
      return TouchIDError.appCancel
    case .authenticationFailed:
      return TouchIDError.authenticationFailed
    case .invalidContext:
      return TouchIDError.invalidContext
    case .passcodeNotSet:
      return TouchIDError.passcodeNotSet
    case .systemCancel:
      return TouchIDError.systemCancel
    case .touchIDLockout:
      return TouchIDError.touchIDLockout
    case .touchIDNotAvailable:
      return TouchIDError.touchIDNotAvailable
    case .touchIDNotEnrolled:
      return TouchIDError.touchIDNotEnrolled
    case .userCancel:
      return TouchIDError.userCancel
    case .userFallback:
      return TouchIDError.userFallback
    }
  }
  
}

extension TouchIDError: Equatable {}

public func ==(lhs: TouchIDError, rhs: TouchIDError) -> Bool {
  switch (lhs, rhs) {
  case (.undeterminedState, .undeterminedState):
    return true
  case (let .unknownError(e1), let .unknownError(e2)):
    return e1 == e2
  case (.appCancel, .appCancel):
    return true
  case (.authenticationFailed, .authenticationFailed):
    return true
  case (.invalidContext, .invalidContext):
    return true
  case (.passcodeNotSet, .passcodeNotSet):
    return true
  case (.systemCancel, .systemCancel):
    return true
  case (.touchIDLockout, .touchIDLockout):
    return true
  case (.touchIDNotAvailable, .touchIDNotAvailable):
    return true
  case (.touchIDNotEnrolled, .touchIDNotEnrolled):
    return true
  case (.userCancel, .userCancel):
    return true
  case (.userFallback, .userFallback):
    return true
  default:
    return false
  }
}
