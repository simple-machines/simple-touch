//
//  ViewController.swift
//  SimpleTouchDemo
//
//  Created by Hamish Rickerby on 19/10/2015.
//  Copyright © 2015 Simple Machines. All rights reserved.
//

import SimpleTouch
import UIKit

class ViewController: UIViewController {
}

// MARK: User Interaction
extension ViewController {
  @IBAction func testHardwareSupport() {
    let message: String
    switch SimpleTouch.hardwareSupportsTouchID {
    case .Success:
      message = "Hardware supports Touch ID"
    default:
      message = "Hardware does not support Touch ID"
    }
    showAlert(message)
  }
  
  @IBAction func testEvaluationSupport() {
    switch SimpleTouch.isTouchIDEnabled {
    case .Success:
      showAlert("Can evaluate Touch ID")
    case .Error(let error):
      displayErrorMessage(error)
    }
  }
  
  @IBAction func runTouchID() {
    let callback: TouchIDPresenterCallback = { response in
      switch response {
      case .Success:
        self.showAlert("Touch ID evaluated successfully")
      case .Error(let error):
        self.displayErrorMessage(error)
      }
    }
    SimpleTouch.presentTouchID("Testing Touch ID", fallbackTitle: "Fallback", callback: callback)
  }
}

// MARK: Helpers
extension ViewController {
  func showAlert(message: String) {
    let alertVC = UIAlertController(title: "Result", message: message, preferredStyle: .Alert)
    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
    alertVC.addAction(defaultAction)
    self.presentViewController(alertVC, animated: true, completion: nil)
  }
  
  func displayErrorMessage(error: TouchIDError) {
    switch error {
    case .AppCancel:
      showAlert("App cancelled authentication")
    case .AuthenticationFailed:
      showAlert("Authentication failed")
    case .InvalidContext:
      showAlert("Invalid authentication context")
    case .PasscodeNotSet:
      showAlert("Users passcode not set")
    case .SystemCancel:
      showAlert("System cancelled authetication")
    case .TouchIDLockout:
      showAlert("User is locked out of Touch ID")
    case .TouchIDNotAvailable:
      showAlert("Touch ID is not available on this device")
    case .TouchIDNotEnrolled:
      showAlert("User has not enrolled for Touch ID")
    case .UndeterminedState:
      showAlert("Undetermined error. If you can get this message to display I'd love to know how.")
    case .UnknownError(let error):
      showAlert("Unknown error. If you can get this message to display I'd love to know how. Error description: \(error.localizedDescription)")
    case .UserCancel:
      showAlert("User cancelled authentication")
    case .UserFallback:
      showAlert("User opted for fallback authetication")
    }
  }
}