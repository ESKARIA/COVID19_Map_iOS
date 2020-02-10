//
//  BaseViewController.swift
//  NCOVMap
//
//  Created by Дмитрий Торопкин on 10.02.2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit
import KRProgressHUD

enum LoadingResult {
    case success
    case none
    case error
    case warning
    case info
}

class BaseViewController: UIViewController {
    
    func showBaseLoading(with message: String?, completion: (() -> Void)? = nil) {
        KRProgressHUD.show(withMessage: message, completion: completion)
    }
    
    func hideBaseLoading(with result: LoadingResult = .none, message: String? = nil) {
        switch result {
        case .success:
            KRProgressHUD.showSuccess(withMessage: message)
        case .none:
            KRProgressHUD.dismiss()
        case .error:
            KRProgressHUD.showError(withMessage: message)
        case .warning:
            KRProgressHUD.showWarning(withMessage: message)
        case .info:
            KRProgressHUD.showInfo(withMessage: message)
        }
    }
}
