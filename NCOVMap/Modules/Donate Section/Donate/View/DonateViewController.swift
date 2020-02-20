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
import Cheers

enum DonatePrice: String {
    
    case ninetyNineCents = "0.99$"
    case fiveDollars = "5$"
    case tenDollats = "10$"
    case twentyFiveDollars = "25$"
    case fiftyDollars = "50$"
    case oneHundredDollars = "100$"
}

class DonateViewController: BaseViewController {
    
    var presenter: DonatePresenterProtocol!
    
    private var lbl_counter: UILabel = UILabel.makeLabel(size: 58, weight: .bold, color: R.color.appMarineBlue().unwrapped())
    private var donateSlider = UISlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.presenter.viewLoaded()
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
        
        self.donateSlider.tintColor = R.color.appRed()
        self.donateSlider.maximumValue = 100
        self.donateSlider.minimumValue = 1
        self.donateSlider.addTarget(self, action: #selector(self.changeValue(_:)), for: .valueChanged)
        self.donateSlider.addTarget(self, action: #selector(self.changeDidEnd(_:)), for: .touchUpInside)
        self.donateSlider.addTarget(self, action: #selector(self.changeDidEnd(_:)), for: .touchUpOutside)
        self.view.addSubview(self.donateSlider)
        self.donateSlider.snp.makeConstraints { (make) in
            make.top.equalTo(self.lbl_counter.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
}

extension DonateViewController: DonateViewProtocol {
    
    func showSuccess() {
        let cheerView = CheerView()
        self.view.addSubview(cheerView)
        cheerView.config.particle = .confetti(allowedShapes: Particle.ConfettiShape.all)
        cheerView.start()
        
        self.lbl_counter.text = R.string.localizable.donate_Bought_Success()
        self.lbl_counter.sizeToFit()
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            cheerView.stop()
            self.donateSlider.setValue(0, animated: true)
            self.lbl_counter.text = DonatePrice.ninetyNineCents.rawValue
        }
    }
    
    func showOkAlert(with title: String, description: String?) {
        self.showBaseOkAlertController(title: title, message: description)
    }
    
    func showLoading() {
        self.showBaseLoading(with: R.string.localizable.donate_Bought_Loading())
    }
    
    func hideLoading() {
        self.hideBaseLoading()
    }
}

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
        
        button.addTarget(self, action: #selector(self.didClickDonate), for: .touchUpInside)
        
        button.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.width.equalTo(140).priority(700)
        }
        
        return button
    }
    
    @objc private func didClickDonate() {
        guard let text = self.lbl_counter.text, let donate = DonatePrice.init(rawValue: text) else {
            return
        }
        self.presenter.didClickDonate(value: donate)
    }
    
    @objc private func changeValue(_ slider: UISlider) {
        
        let intValue = Int(slider.value)
        //0.99, 5, 10, 25, 50, 100
        if (1...17).contains(intValue) {
            self.lbl_counter.text = DonatePrice.ninetyNineCents.rawValue
        } else if (17...34).contains(intValue) {
            self.lbl_counter.text = DonatePrice.fiveDollars.rawValue
        } else if (34...51).contains(intValue) {
            self.lbl_counter.text = DonatePrice.tenDollats.rawValue
        } else if (51...68).contains(intValue) {
            self.lbl_counter.text = DonatePrice.twentyFiveDollars.rawValue
        } else if (68...85).contains(intValue) {
            self.lbl_counter.text = DonatePrice.fiftyDollars.rawValue
        } else if (85...100).contains(intValue) {
            self.lbl_counter.text = DonatePrice.oneHundredDollars.rawValue
        }
    }
    
    @objc private func changeDidEnd(_ slider: UISlider) {
        let intValue = Int(slider.value)
        if (1...17).contains(intValue) {
            self.donateSlider.setValue(Float(0), animated: true)
        } else if (17...34).contains(intValue) {
            self.donateSlider.setValue(Float(25), animated: true)
        } else if (34...51).contains(intValue) {
            self.donateSlider.setValue(Float(42), animated: true)
        } else if (51...68).contains(intValue) {
            self.donateSlider.setValue(Float(59), animated: true)
        } else if (68...85).contains(intValue) {
            self.donateSlider.setValue(Float(76), animated: true)
        } else if (85...100).contains(intValue) {
            self.donateSlider.setValue(Float(100), animated: true)
        }
    }
}
