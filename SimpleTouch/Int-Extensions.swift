//
//  Int-Extensions.swift
//  SimpleTouch
//
//  Created by Hamish Rickerby on 19/10/2015.
//  Copyright © 2015 Simple Machines. All rights reserved.
//

import Foundation

extension Int {
  internal func toEnum<Enum: RawRepresentable where Enum.RawValue == Int>() -> Enum? {
    return Enum(rawValue: self)
  }
}
