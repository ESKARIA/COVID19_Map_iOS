//
//  StatsTextCell.swift
//  NCOVMap
//
//  Created by Emil Karimov on 18.02.2020.
//  Copyright © 2020 ESKARIA LLC. All rights reserved.
//

import UIKit
import DevHelper

final class StatsTextCell: BaseTableCell {

    private var lbl_description: UILabel = UILabel.makeLabel(size: 10, weight: .regular, color: R.color.appDark().unwrapped())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createUI()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createUI() {
        self.lbl_description.numberOfLines = 0
        self.contentView.addSubview(self.lbl_description)
        self.lbl_description.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.greaterThanOrEqualTo(100)
            $0.bottom.equalToSuperview()
        }
    }

    func display(_ type: DescriptionCase, model: StatisticsModel) {
        self.lbl_description.text = type.description
    }
}
