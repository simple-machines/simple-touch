//
//  TouchIDResponse.swift
//  SimpleTouch
//
//  Created by Hamish Rickerby on 19/10/2015.
//  Copyright © 2015 Simple Machines. All rights reserved.
//

public enum TouchIDResponse {
  case Success
  case Error(TouchIDError)
}

extension TouchIDResponse: Equatable {}

public func == (lhs: TouchIDResponse, rhs: TouchIDResponse) -> Bool {
  switch (lhs, rhs) {
  case (.Success, .Success):
    return true
  case (let .Error(e1), let .Error(e2)):
    return e1 == e2
  default:
    return false
  }
}
