//
//  TouchIDError.swift
//  SimpleTouch
//
//  Created by Hamish Rickerby on 19/10/2015.
//  Copyright © 2015 Simple Machines. All rights reserved.
//

import LocalAuthentication

// Wrapper for LAError as an ErrorType + 2 new errors, that _should_ never throw
public enum TouchIDError: ErrorType {
  // An error we may get when we don't have a real error, but policy evaluation fails.
  // Will hopefully never happen.
  case UndeterminedState
  
  // Error when the code is not a defined LAError type.
  // Will hopefully never happen.
  case UnknownError(NSError)
  
  // LAError cases
  case AppCancel
  case AuthenticationFailed
  case InvalidContext
  case PasscodeNotSet
  case SystemCancel
  case TouchIDLockout
  case TouchIDNotAvailable
  case TouchIDNotEnrolled
  case UserCancel
  case UserFallback
  
  internal static func createError(error: NSError?) -> TouchIDError {
    guard let tidError = error else {
      return TouchIDError.UndeterminedState
    }
    
    guard let type: LAError = tidError.code.toEnum() else {
      return TouchIDError.UnknownError(tidError)
    }
    
    switch type {
    case .AppCancel:
      return TouchIDError.AppCancel
    case .AuthenticationFailed:
      return TouchIDError.AuthenticationFailed
    case .InvalidContext:
      return TouchIDError.InvalidContext
    case .PasscodeNotSet:
      return TouchIDError.PasscodeNotSet
    case .SystemCancel:
      return TouchIDError.SystemCancel
    case .TouchIDLockout:
      return TouchIDError.TouchIDLockout
    case .TouchIDNotAvailable:
      return TouchIDError.TouchIDNotAvailable
    case .TouchIDNotEnrolled:
      return TouchIDError.TouchIDNotEnrolled
    case .UserCancel:
      return TouchIDError.UserCancel
    case .UserFallback:
      return TouchIDError.UserFallback
    }
  }
  
}

extension TouchIDError: Equatable {}

public func ==(lhs: TouchIDError, rhs: TouchIDError) -> Bool {
  switch (lhs, rhs) {
  case (.UndeterminedState, .UndeterminedState):
    return true
  case (let .UnknownError(e1), let .UnknownError(e2)):
    return e1 == e2
  case (.AppCancel, .AppCancel):
    return true
  case (.AuthenticationFailed, .AuthenticationFailed):
    return true
  case (.InvalidContext, .InvalidContext):
    return true
  case (.PasscodeNotSet, .PasscodeNotSet):
    return true
  case (.SystemCancel, .SystemCancel):
    return true
  case (.TouchIDLockout, .TouchIDLockout):
    return true
  case (.TouchIDNotAvailable, .TouchIDNotAvailable):
    return true
  case (.TouchIDNotEnrolled, .TouchIDNotEnrolled):
    return true
  case (.UserCancel, .UserCancel):
    return true
  case (.UserFallback, .UserFallback):
    return true
  default:
    return false
  }
}
