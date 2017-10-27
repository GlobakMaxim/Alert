//
//  Alert.swift
//
//  Created by Globak Maxim on 02/10/2017.
//  Copyright © 2017 Maxim Globak. All rights reserved.
//

class Alert {
  typealias Handler = () -> Void
  private var alertController: UIAlertController

  init(title: String, message: String) {
    alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
  }

  func button(title: String, action: Handler?) -> Self {
    return addAction(title: title, style: .default, action: action)
  }

  func cancel(title: String, action: Handler?) -> Self {
    return addAction(title: title, style: .cancel, action: action)
  }

  func destructive(title: String, action: Handler?) -> Self {
    return addAction(title: title, style: .destructive, action: action)
  }

  private func addAction(title: String, style: UIAlertActionStyle, action: Handler?) -> Self {
    let action = UIAlertAction(title: title, style: style) { _ in
      action?()
    }
    alertController.addAction(action)
    return self
  }

  func show(on viewController: UIViewController? = nil,
            animated: Bool = true,
            completion: Handler? = nil) {
    guard let vc = viewController ?? findTopViewController() else { return }
    vc.present(alertController, animated: animated, completion: completion)
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
