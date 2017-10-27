//
//  ActionSheet.swift
//
//  Created by Maxim Globak on 28.10.17.
//  Copyright © 2017 Maxim Globak. All rights reserved.
//

import UIKit

class ActionSheet {
  typealias Handler = () -> Void

  var alertController: UIAlertController

  init(title: String?, message: String?) {
    alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
  }

  func button(_ title: String, action: Handler? = nil) -> Self {
    return addAction(title: title, style: .default, action: action)
  }

  func cancel(_ title: String, action: Handler? = nil) -> Self {
    return addAction(title: title, style: .cancel, action: action)
  }

  func destructive(_ title: String, action: Handler? = nil) -> Self {
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

extension ActionSheet {
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
