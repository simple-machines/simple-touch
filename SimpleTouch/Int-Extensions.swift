//
//  Int-Extensions.swift
//  SimpleTouch
//
//  Created by Hamish Rickerby on 19/10/2015.
//  Copyright © 2015 Simple Machines. All rights reserved.
//

import Foundation

extension Int {
  internal func toEnum<Enum: RawRepresentable>() -> Enum? where Enum.RawValue == Int {
    return Enum(rawValue: self)
  }
}
