//
//  Alert.swift
//
//  Created by Globak Maxim on 02/10/2017.
//  Copyright © 2017 Maxim Globak. All rights reserved.
//

import UIKit

public class Alert {
  
  public typealias Handler = () -> Void
  private var alertController: UIAlertController
  
  public init(title: String, message: String) {
    alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
  }
  
  public func button(_ title: String, action: Handler? = nil) -> Self {
    return addAction(title: title, style: .default, action: action)
  }
  
  public func cancel(_ title: String, action: Handler? = nil) -> Self {
    return addAction(title: title, style: .cancel, action: action)
  }
  
  public func destructive(_ title: String, action: Handler? = nil) -> Self {
    return addAction(title: title, style: .destructive, action: action)
  }
  
  private func addAction(title: String, style: UIAlertAction.Style, action: Handler?) -> Self {
    let action = UIAlertAction(title: title, style: style) { _ in
      action?()
    }
    alertController.addAction(action)
    return self
  }
  
  public func show(on viewController: UIViewController? = nil,
                   animated: Bool = true,
                   completion: Handler? = nil) {
    guard let vc = viewController ?? findTopViewController() else { return }
    DispatchQueue.main.async {
      vc.present(self.alertController, animated: animated, completion: completion)
    }
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
