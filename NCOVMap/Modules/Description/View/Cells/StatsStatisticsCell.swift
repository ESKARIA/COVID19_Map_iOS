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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createUI()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createUI() {
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

    func display(_ type: DescriptionCase, model: StatisticsModel) {
        switch type {
        case .confirmed:

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
        configuration.compressionMode = .paramDominates
        return configuration
    }

    private func hideStats(hidden: Bool) {
        self.lbl_stats_counter_title.isHidden = hidden
        self.sv_stats.isHidden = hidden
    }
}
