//
//  InfoWireFrame.swift
//  NCOV_Map
//
//  Created by Emil Karimov on 19/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit

class InfoWireFrame: BaseWireFrame {
    //func presentSomeViewController(from view: InfoViewProtocol) {
    //    guard let fromView = view as? UIViewController else { return }
    //    let viewController = self.resolver.someViewController()
    //    fromView.navigationController?.pushViewController(viewController, animated: true)
    //}
}

extension InfoWireFrame: InfoWireFrameProtocol {
    func presentInfoDetail(from view: InfoViewProtocol?, with type: InfoRow) {
        guard let fromView = view as? UIViewController else { return }
        let viewController = self.resolver.presentInfoDetailViewController(type: type)
        fromView.navigationController?.pushViewController(viewController, animated: true)
    }
    

}
