//
//  Record.swift
//  SignOut
//
//  Created by Wikipedia Brown on 7/27/19.
//  Copyright © 2019 IamGoodBad. All rights reserved.
//

import Foundation

struct Record {
    let date: Date
    let pid: String
    let firstName: String
    let lastName: String
    let sex: String
    let homeCIF: String
    let lastInitialIssue: Date
    let grade: String
    let unit: String
    let dmos: String
    let expectedClearance: String
    let branch: String
    let lastTransactionDocumentNumber: String
    let lastTransactionDTTC: String
    let lastTransactionCIFName: String
    let lastTransactionDate: Date
    var items: [Item] = []
}
