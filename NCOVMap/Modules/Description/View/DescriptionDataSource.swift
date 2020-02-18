//
//  DescriptionDataSource.swift
//  NCOVMap
//
//  Created by Emil Karimov on 18.02.2020.
//  Copyright © 2020 ESKARIA LLC. All rights reserved.
//

import UIKit

enum DataItems: CaseIterable {
    case title
    case description
    case stats

    var identifier: String {
        switch self {
        case .title: return StatsTitleCell.identifier
        case .description: return StatsTextCell.identifier
        case .stats: return StatsStatisticsCell.identifier
        }
    }
}

final class DescriptionDataSource {

    var items: [DataItems] = []

    var type: DescriptionCase = .confirmed {
        didSet {
            switch type {
            case .confirmed:
                self.items = [.title, .description, .stats]
            case .died:
                self.items = [.title, .description]
            case .recovered:
                self.items = [.title, .description]
            }
        }
    }

    var model: StatisticsModel!


    func numberOfRows(in section: Int) -> Int {
        return self.items.count
    }

    func item(at indexPath: IndexPath) -> DataItems {
        return self.items[indexPath.row]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.item(at: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath) as? BaseTableCell else {
            return UITableViewCell()
        }

        if let cell = cell as? StatsTitleCell {
            cell.display(self.type, model: model)
        } else if let cell = cell as? StatsTextCell {
            cell.display(self.type, model: model)
        } else if let cell = cell as? StatsStatisticsCell {
            cell.display(self.type, model: model)
        }

        return cell
    }
}
