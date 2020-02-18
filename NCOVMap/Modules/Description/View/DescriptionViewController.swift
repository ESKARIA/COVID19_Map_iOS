//
//  DescriptionViewController.swift
//  NCOV_Map
//
//  Created by Emil Karimov on 17/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit
import SnapKit

class DescriptionViewController: BaseViewController {

    var presenter: DescriptionPresenterProtocol!

    private var lbl_title: UILabel = UILabel.makeLabel(size: 14, weight: .regular, color: R.color.appBattleshipGrey().unwrapped())
    private var lbl_count: UILabel = UILabel.makeLabel(size: 34, weight: .heavy, color: R.color.appMarineBlue().unwrapped())
    private var img_icon: UIImageView = UIImageView(image: R.image.confirmed_icon())

    private var lbl_description: UILabel = UILabel.makeLabel(size: 10, weight: .regular, color: R.color.appDark().unwrapped())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.presenter.viewDidLoad()
    }

    private func createUI() {

        self.view.backgroundColor = .white

        self.view.addSubview(self.img_icon)
        self.view.addSubview(self.lbl_title)
        self.view.addSubview(self.lbl_count)
        self.view.addSubview(self.lbl_description)

        self.img_icon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.left.equalToSuperview().offset(16)
            $0.width.height.equalTo(59)
        }

        let separatorLine = UIView()
        separatorLine.backgroundColor = R.color.appRed()

        self.view.addSubview(separatorLine)
        separatorLine.snp.makeConstraints {
            $0.bottom.equalTo(self.img_icon)
            $0.left.equalTo(self.img_icon.snp.right).offset(12)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(1)
        }

        self.lbl_count.snp.makeConstraints {
            $0.bottom.equalTo(separatorLine.snp.top).offset(-4)
            $0.left.right.equalTo(separatorLine)
        }

        self.lbl_title.snp.makeConstraints {
            $0.top.equalTo(self.img_icon)
            $0.bottom.equalTo(self.lbl_count.snp.top).offset(-1)
            $0.left.right.equalTo(separatorLine)
        }
        
        self.lbl_description.snp.makeConstraints {
            $0.top.equalTo(separatorLine.snp.bottom).offset(24)
            $0.left.equalTo(self.img_icon)
            $0.right.equalTo(separatorLine)
            $0.height.greaterThanOrEqualTo(100)
        }
        self.lbl_description.numberOfLines = 0
    }
}

extension DescriptionViewController: DescriptionViewProtocol {

    func setContent(_ type: DescriptionCase, model: StatisticsModel) {

        self.img_icon.image = type.icon
        self.lbl_title.text = type.title
        self.lbl_description.text = type.description
        switch type {
        case .confirmed:
            self.lbl_count.text = "\(model.totalInfo.totalConfirmed)"
        case .died:
            self.lbl_count.text = "\(model.totalInfo.totalDeath)"
        case .recovered:
            self.lbl_count.text = "\(model.totalInfo.totalRecovered)"
        }
    }
}
