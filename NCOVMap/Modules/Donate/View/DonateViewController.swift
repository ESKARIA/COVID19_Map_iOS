//
//  DonateViewController.swift
//  NCOV_Map
//
//  Created by Emil Karimov on 18/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit
import SnapKit

class DonateViewController: BaseViewController {

    var presenter: DonatePresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()

    }

    private func createUI() {

        let label = UILabel.makeLabel(size: 36, weight: .medium, color: .black)
        label.text = "Donate"

        self.view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

}
extension DonateViewController: DonateViewProtocol { }
