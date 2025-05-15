//
//  Error+Ext.swift
//  Credenza
//
//  Created by Kuba on 5/15/25.
//

import Foundation

extension Error {
    
    var eventParameters: [String: Any] {
        [
            "error_description": self.localizedDescription
        ]
    }
}
