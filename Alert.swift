//
//  Alert.swift
//
//  Created by Globak Maxim on 02/10/2017.
//  Copyright © 2017 Maxim Globak. All rights reserved.
//

import UIKit

class Alert {

  typealias Closure = () -> Void

  private var alertController: UIAlertController
  
  init(title: String, message: String) {
    alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
  }

  func button(_ title: String,
              style: UITableViewRowActionStyle? = .default,
              closure: Closure? = nil) -> Alert {
    let action = UIAlertAction(title: title, style: .default) { _ in closure?() }
    alertController.addAction(action)
    return self
  }

  func show(on viewController: UIViewController? = nil,
            animated: Bool = true,
            completion: Closure? = nil) {
    guard let vc = viewController ?? findTopViewController() else { return }
    vc.present(alertController, animated: animated, completion: completion)
  }
}

extension Alert {
    static func info(title: String, message: String) -> Alert {
    let alert = Alert(title: title, message: message)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.alertController.addAction(okAction)
    return alert
  }
}

extension Alert {
  private func findTopViewController() -> UIViewController? {
    guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
      return nil
    }
    return findTopViewController(in: rootViewController)
  }

  private func findTopViewController(in viewController: UIViewController) -> UIViewController {
    if let navigationController = viewController as? UINavigationController {
      if let visibleViewController = navigationController.visibleViewController {
        return findTopViewController(in: visibleViewController)
      }
    }
    if let tabController = viewController as? UITabBarController {
      if let selectedViewController = tabController.selectedViewController {
        return findTopViewController(in: selectedViewController)
      }
    }
    if let presented = viewController.presentedViewController {
      return presented
    }
    return viewController
  }
}
