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
