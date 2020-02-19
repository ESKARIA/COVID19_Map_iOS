//
//  DonateViewController.swift
//  NCOV_Map
//
//  Created by Emil Karimov on 18/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit
import SnapKit
import DevHelper

class DonateViewController: BaseViewController {

    var presenter: DonatePresenterProtocol!

    private var lbl_counter: UILabel = UILabel.makeLabel(size: 58, weight: .bold, color: R.color.appMarineBlue().unwrapped())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()

    }

    private func createUI() {

        self.view.backgroundColor = R.color.appDark()
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        self.customNavigationTitle(title: R.string.localizable.donate_title())

        let lightContainer = UIView()
        lightContainer.backgroundColor = .white

        let bearHead = UIImageView(image: R.image.bearHead())

        self.view.addSubview(bearHead)
        self.view.addSubview(lightContainer)
        lightContainer.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.top.equalTo(self.view.snp.centerY).offset(-100)
        }
        lightContainer.cornerRadius(10)

        bearHead.snp.makeConstraints {
            $0.bottom.equalTo(lightContainer.snp.top).offset(36)
            $0.width.equalTo(166)
            $0.height.equalTo(149)
            $0.centerX.equalToSuperview()
        }

        let bearHands = UIImageView(image: R.image.bearHands())
        self.view.addSubview(bearHands)

        bearHands.snp.makeConstraints {
            $0.centerY.equalTo(lightContainer.snp.top)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(250)
            $0.height.equalTo(27)
        }

        let description_lbl = UILabel.makeLabel(size: 10, weight: .regular, color: R.color.appMarineBlue().unwrapped())
        lightContainer.addSubview(description_lbl)
        description_lbl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(65)
            $0.left.right.equalToSuperview()
        }

        description_lbl.numberOfLines = 0

        description_lbl.text = R.string.localizable.donate_description()
        description_lbl.textAlignment = .center

        let donate_btn = self.createDonateButton()

        lightContainer.addSubview(donate_btn)
        donate_btn.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-42)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        
        lightContainer.addSubview(self.lbl_counter)
        self.lbl_counter.snp.makeConstraints {
            $0.top.equalTo(description_lbl.snp.bottom).offset(34)
            $0.centerX.equalToSuperview()
        }
        
        self.lbl_counter.textAlignment = .right
        self.lbl_counter.text = "0.99$"
    }
}

extension DonateViewController: DonateViewProtocol { }

// MARK: - Private
extension DonateViewController {

    func createDonateButton() -> UIButton {

        let button = UIButton()
        button.backgroundColor = R.color.appRed().unwrapped()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        button.contentHorizontalAlignment = .center

        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.layer.cornerRadius = 10
        button.setTitle(R.string.localizable.donate_donnateButton_title(), for: .normal)

        button.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.width.equalTo(140).priority(700)
        }

        return button
    }
}
