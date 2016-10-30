//
//  TouchIDResponse.swift
//  SimpleTouch
//
//  Created by Hamish Rickerby on 19/10/2015.
//  Copyright © 2015 Simple Machines. All rights reserved.
//

public enum TouchIDResponse {
  case success
  case error(TouchIDError)
}

extension TouchIDResponse: Equatable {}

public func == (lhs: TouchIDResponse, rhs: TouchIDResponse) -> Bool {
  switch (lhs, rhs) {
  case (.success, .success):
    return true
  case (let .error(e1), let .error(e2)):
    return e1 == e2
  default:
    return false
  }
}
