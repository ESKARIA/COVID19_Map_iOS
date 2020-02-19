//
//  InfoTableCell.swift
//  NCOVMap
//
//  Created by Emil Karimov on 19.02.2020.
//  Copyright © 2020 ESKARIA LLC. All rights reserved.
//

import UIKit

final class InfoTableCell: BaseTableCell {

    private var lbl_title: UILabel = UILabel.makeLabel(size: 17, weight: .regular, color: .white)
    
    internal override func createUI() {
        super.createUI()
    
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        
        let container = UIView()
        container.backgroundColor = R.color.appBattleshipGrey().unwrapped().withAlphaComponent(0.55)
        
        self.contentView.addSubview(container)
        
        container.snp.makeConstraints {
            $0.top.equalToSuperview().offset(9)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-9)
        }
        
        container.addSubview(self.lbl_title)
        self.lbl_title.snp.makeConstraints {
            $0.top.equalToSuperview().offset(9)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-9)
            $0.height.greaterThanOrEqualTo(84)
        }
        
        self.lbl_title.textAlignment = .center
        self.lbl_title.numberOfLines = 0
        
        container.cornerRadius(10)
    }
    
    func display(_ model: InfoRow) {
        self.lbl_title.text = model.title
    }
}
