//
//  DescriptionViewController.swift
//  NCOV_Map
//
//  Created by Emil Karimov on 17/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit
import SnapKit
import DevHelper

class DescriptionViewController: BaseViewController {

    var presenter: DescriptionPresenterProtocol!

    private var lbl_title: UILabel = UILabel.makeLabel(size: 14, weight: .regular, color: R.color.appBattleshipGrey().unwrapped())
    private var lbl_count: UILabel = UILabel.makeLabel(size: 34, weight: .heavy, color: R.color.appMarineBlue().unwrapped())
    private var img_icon: UIImageView = UIImageView(image: R.image.confirmed_icon())
    private var lbl_description: UILabel = UILabel.makeLabel(size: 10, weight: .regular, color: R.color.appDark().unwrapped())
    private var lbl_stats_counter_title: UILabel = UILabel.makeLabel(size: 17, weight: .bold, color: R.color.appMarineBlue().unwrapped())
    private var sv_stats: UIStackView = DHUIBuilder.make.stackView(orientation: .vertical, distribution: .equalSpacing, spacing: 0)


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
        self.view.addSubview(self.lbl_stats_counter_title)
        self.view.addSubview(self.sv_stats)

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

        self.lbl_stats_counter_title.snp.makeConstraints {
            $0.top.equalTo(self.lbl_description.snp.bottom).offset(15)
            $0.left.equalTo(self.img_icon)
            $0.right.equalTo(separatorLine)
        }
        self.lbl_stats_counter_title.numberOfLines = 0
        self.lbl_stats_counter_title.text = R.string.localizable.descript_enjured_title()

        self.sv_stats.snp.makeConstraints {
            $0.top.equalTo(self.lbl_stats_counter_title.snp.bottom).offset(15)
            $0.left.equalTo(self.img_icon)
            $0.right.equalTo(separatorLine)
        }
    }
}

// MARK: - Private
extension DescriptionViewController {
    
    private func hideStats(hidden: Bool) {
        self.lbl_stats_counter_title.isHidden = hidden
        self.sv_stats.isHidden = hidden
    }
    
    private func getConfig() -> ParamValueViewConfiguration {
        var configuration = ParamValueViewConfiguration()
        configuration.fontParam = UIFont.systemFont(ofSize: 14, weight: .regular)
        configuration.fontValue = UIFont.systemFont(ofSize: 14, weight: .regular)
        configuration.colorParam = R.color.appBattleshipGrey().unwrapped()
        configuration.colorValue = R.color.appBattleshipGrey().unwrapped()
        configuration.verticalAlighnmentValue = VerticalAlignmentMode.middle
        configuration.verticalAlighnmentParam = VerticalAlignmentMode.middle
        configuration.compressionMode = .paramDominates
        return configuration
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

            for country in model.mergeCountries().sorted(by: { $0.stats.confirmed > $1.stats.confirmed }) {
                let container = UIView()
                let view = ParamValueView(configuration: self.getConfig())
                view.labelParam.text = country.countryName
                view.labelValue.text = "\(country.stats.confirmed)"
                view.labelValue.textAlignment = .left
                container.addSubview(view)
                let separator = UIView()
                container.addSubview(separator)
                view.snp.makeConstraints {
                    $0.edges.equalToSuperview()
                    $0.height.equalTo(31)
                }
                separator.snp.makeConstraints {
                    $0.bottom.equalToSuperview()
                    $0.left.right.equalToSuperview()
                    $0.height.equalTo(1)
                }
                separator.backgroundColor = R.color.appBattleshipGrey()?.withAlphaComponent(0.25)
                self.sv_stats.addArrangedSubview(container)
            }
        case .died:
            self.hideStats(hidden: true)
            self.lbl_count.text = "\(model.totalInfo.totalDeath)"
        case .recovered:
            self.hideStats(hidden: true)
            self.lbl_count.text = "\(model.totalInfo.totalRecovered)"
        }
    }
}
