//
//  InfoDetailViewController.swift
//  NCOV_Map
//
//  Created by Emil Karimov on 19/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit
import SnapKit

class InfoDetailViewController: BaseViewController {

    var presenter: InfoDetailPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func createUI() {
        self.view.backgroundColor = R.color.appDark()

        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = R.color.appDark()
        self.navigationController?.navigationBar.tintColor = R.color.appLightGray()
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

}
extension InfoDetailViewController: InfoDetailViewProtocol {
    func setDetails(_ text: String) {
        
    }
}
