//
//  String+Extension.swift
//  NCOVMap
//
//  Created by Emil Karimov on 18.02.2020.
//  Copyright © 2020 ESKARIA LLC. All rights reserved.
//

import Foundation

extension String {

    static func unwrap(_ text: String?, placeholder: String = "-") -> String {

        if let text = text {

            return text.count > 0 ? text : placeholder
        } else {

            return placeholder
        }
    }
}
