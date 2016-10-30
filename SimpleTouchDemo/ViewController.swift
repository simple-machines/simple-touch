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
    case .success:
      message = "Hardware supports Touch ID"
    default:
      message = "Hardware does not support Touch ID"
    }
    showAlert(message: message)
  }
  
  @IBAction func testEvaluationSupport() {
    switch SimpleTouch.isTouchIDEnabled {
    case .success:
      showAlert(message: "Can evaluate Touch ID")
    case .error(let error):
      displayErrorMessage(error: error)
    }
  }
  
  @IBAction func runTouchID() {
    let callback: TouchIDPresenterCallback = { response in
      switch response {
      case .success:
        self.showAlert(message: "Touch ID evaluated successfully")
      case .error(let error):
        self.displayErrorMessage(error: error)
      }
    }
    SimpleTouch.presentTouchID("Testing Touch ID", fallbackTitle: "Fallback", callback: callback)
  }
}

// MARK: Helpers
extension ViewController {
  func showAlert(message: String) {
    let alertVC = UIAlertController(title: "Result", message: message, preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertVC.addAction(defaultAction)
    self.present(alertVC, animated: true, completion: nil)
  }
  
  func displayErrorMessage(error: TouchIDError) {
    switch error {
    case .appCancel:
      showAlert(message: "App cancelled authentication")
    case .authenticationFailed:
      showAlert(message: "Authentication failed")
    case .invalidContext:
      showAlert(message: "Invalid authentication context")
    case .passcodeNotSet:
      showAlert(message: "Users passcode not set")
    case .systemCancel:
      showAlert(message: "System cancelled authetication")
    case .touchIDLockout:
      showAlert(message: "User is locked out of Touch ID")
    case .touchIDNotAvailable:
      showAlert(message: "Touch ID is not available on this device")
    case .touchIDNotEnrolled:
      showAlert(message: "User has not enrolled for Touch ID")
    case .undeterminedState:
      showAlert(message: "Undetermined error. If you can get this message to display I'd love to know how.")
    case .unknownError(let error):
      showAlert(message: "Unknown error. If you can get this message to display I'd love to know how. Error description: \(error.localizedDescription)")
    case .userCancel:
      showAlert(message: "User cancelled authentication")
    case .userFallback:
      showAlert(message: "User opted for fallback authetication")
    }
  }
}
