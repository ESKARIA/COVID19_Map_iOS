//
//  NavigationViewController.swift
//  NCOV_Map
//
//  Created by Dmitriy on 10/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit
import SnapKit

class NavigationViewController: UINavigationController {

    var presenter: NavigationPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()

    }

    private func createUI() {

    }

}
extension NavigationViewController: NavigationViewProtocol { }
