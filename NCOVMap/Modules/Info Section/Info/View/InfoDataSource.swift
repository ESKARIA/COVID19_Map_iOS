//
//  InfoDataSource.swift
//  NCOVMap
//
//  Created by Emil Karimov on 19.02.2020.
//  Copyright © 2020 ESKARIA LLC. All rights reserved.
//

import UIKit

enum InfoRow: CaseIterable {

    case coronavirus
    case danger
    case can
    case canTransfer
    case medicine
    case protect

    var title: String {
        switch self {
        case .coronavirus:
            return R.string.localizable.inforow_coronavirus()
        case .danger:
            return R.string.localizable.inforow_danger()
        case .can:
            return R.string.localizable.inforow_can()
        case .canTransfer:
            return R.string.localizable.inforow_canTransfer()
        case .medicine:
            return R.string.localizable.inforow_medicine()
        case .protect:
            return R.string.localizable.inforow_protect()
        }
    }
}

final class InfoDataSource {

    var items: [InfoRow] = InfoRow.allCases

    func numberOfRows(in section: Int) -> Int {
        return self.items.count
    }

    func item(at indexPath: IndexPath) -> InfoRow {
        return self.items[indexPath.row]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.item(at: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableCell.identifier, for: indexPath) as? InfoTableCell else {
            return UITableViewCell()
        }
        cell.display(item)
        
        return cell
    }
}
