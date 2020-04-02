//
//  StatsTitleCell.swift
//  NCOVMap
//
//  Created by Emil Karimov on 18.02.2020.
//  Copyright © 2020 ESKARIA LLC. All rights reserved.
//

import UIKit
import DevHelper

final class StatsTitleCell: BaseTableCell {

    private var lbl_title: UILabel = UILabel.makeLabel(size: 14, weight: .regular, color: R.color.appBattleshipGrey().unwrapped())
    private var lbl_count: UILabel = UILabel.makeLabel(size: 34, weight: .heavy, color: R.color.appMarineBlue().unwrapped())
    private var img_icon: UIImageView = UIImageView(image: R.image.confirmed_icon())

    internal override func createUI() {
        super.createUI()
        self.contentView.addSubview(self.img_icon)
        self.contentView.addSubview(self.lbl_title)
        self.contentView.addSubview(self.lbl_count)

        self.img_icon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.left.equalToSuperview().offset(16)
            $0.width.height.equalTo(59)
            $0.bottom.equalToSuperview().offset(-10)
        }

        let separatorLine = UIView()
        separatorLine.backgroundColor = R.color.appRed()

        contentView.addSubview(separatorLine)
        separatorLine.snp.makeConstraints {
            $0.bottom.equalTo(self.img_icon).offset(-5)
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
    }

    func display(_ type: DescriptionCase, models: [ModelCountry]) {
        self.img_icon.image = type.icon
        self.lbl_title.text = type.title
        var totalConfirmed = 0
        var totalDeath = 0
        var totalRecovered = 0

        models.forEach {
            totalConfirmed += $0.cases
            totalDeath += $0.deaths
            totalRecovered += $0.recovered
        }
        switch type {
        case .confirmed: self.lbl_count.text = "\(totalConfirmed)"
        case .died: self.lbl_count.text = "\(totalDeath)"
        case .recovered: self.lbl_count.text = "\(totalRecovered)"
        }
    }
}
