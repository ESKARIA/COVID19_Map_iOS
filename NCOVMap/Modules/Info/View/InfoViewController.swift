//
//  InfoViewController.swift
//  NCOV_Map
//
//  Created by Emil Karimov on 19/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit
import SnapKit

class InfoViewController: BaseViewController {

    var presenter: InfoPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()

    }

    private func createUI() {
        self.view.backgroundColor = R.color.appDark()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.customNavigationTitle(title: R.string.localizable.info_title())
    }

}
extension InfoViewController: InfoViewProtocol { }
