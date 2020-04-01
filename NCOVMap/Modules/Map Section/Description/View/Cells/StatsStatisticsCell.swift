//
//  StatsStatisticsCell.swift
//  NCOVMap
//
//  Created by Emil Karimov on 18.02.2020.
//  Copyright © 2020 ESKARIA LLC. All rights reserved.
//

import UIKit
import DevHelper

final class StatsStatisticsCell: BaseTableCell {

    private var lbl_stats_counter_title: UILabel = UILabel.makeLabel(size: 17, weight: .bold, color: R.color.appMarineBlue().unwrapped())
    private var sv_stats: UIStackView = DHUIBuilder.make.stackView(orientation: .vertical, distribution: .equalSpacing, spacing: 0)

    internal override func createUI() {
        super.createUI()
        self.contentView.addSubview(self.lbl_stats_counter_title)
        self.contentView.addSubview(self.sv_stats)

        self.lbl_stats_counter_title.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        self.lbl_stats_counter_title.numberOfLines = 0
        self.lbl_stats_counter_title.text = R.string.localizable.descript_enjured_title()

        self.sv_stats.snp.makeConstraints {
            $0.top.equalTo(self.lbl_stats_counter_title.snp.bottom).offset(15)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-30)
        }
    }

    func display(_ type: DescriptionCase, models: [ModelCountry], fromCountry: String?) {
        switch type {
        case .confirmed:

            for model in models.sorted(by: { $0.cases > $1.cases }) {
                let container = UIView()
                let view = ParamValueView(configuration: self.getConfig())
                view.labelParam.text = model.country
                view.labelValue.text = "\(model.cases)"
                view.labelValue.textAlignment = .left

                let separator = UIView()
                container.addSubview(view)
                container.addSubview(separator)

                let rightOffset = UIScreen.main.bounds.width / 3

                view.snp.makeConstraints {
                    $0.top.bottom.equalToSuperview()
                    $0.left.equalToSuperview()
                    $0.right.equalToSuperview()//.offset(-(rightOffset + 77))
                    $0.height.equalTo(31)
                }
                separator.snp.makeConstraints {
                    $0.bottom.equalToSuperview()
                    $0.left.equalToSuperview()
                    $0.right.equalToSuperview().offset(-rightOffset)
                    $0.height.equalTo(1)
                }
                separator.backgroundColor = R.color.appBattleshipGrey()?.withAlphaComponent(0.25)
                if let fromCountry = model.fromCountry, model.country.contains(fromCountry) {
                    view.labelValue.textColor = R.color.appRed()
                    view.labelParam.textColor = R.color.appRed()
                    self.sv_stats.insertArrangedSubview(container, at: 0)
                } else {
                    self.sv_stats.addArrangedSubview(container)
                }
            }

        case .died:
            self.hideStats(hidden: true)
        case .recovered:
            self.hideStats(hidden: true)
        }
    }

    private func getConfig() -> ParamValueViewConfiguration {
        var configuration = ParamValueViewConfiguration()
        configuration.fontParam = UIFont.systemFont(ofSize: 14, weight: .regular)
        configuration.fontValue = UIFont.systemFont(ofSize: 14, weight: .regular)
        configuration.colorParam = R.color.appBattleshipGrey().unwrapped()
        configuration.colorValue = R.color.appBattleshipGrey().unwrapped()
        configuration.verticalAlighnmentValue = VerticalAlignmentMode.middle
        configuration.verticalAlighnmentParam = VerticalAlignmentMode.middle
        configuration.compressionMode = .fixedParamWidth(width: 100)
        configuration.valueAligment = .left
        return configuration
    }

    private func hideStats(hidden: Bool) {
        self.lbl_stats_counter_title.isHidden = hidden
        self.sv_stats.isHidden = hidden
    }
}
