//
//  ScanViewController.swift
//  SignOut
//
//  Created by Wikipedia Brown on 7/27/19.
//  Copyright © 2019 IamGoodBad. All rights reserved.
//

import PDFKit

class ScanViewController: UIViewController {
    
    private let timeAndDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "YYYY/MM/DD' 'HH:mm:ss"
        return dateFormatter
    }()
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "YYYY/MM/DD"
        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        let url = Bundle.main.url(forResource: "SelfServiceServlet", withExtension: "pdf")
        
        let document = PDFDocument(url: url!)

        scandocument(pdfDocument: document!)
    }
    
    private func scandocument(pdfDocument: PDFDocument) {
        
        let parsedPDF = parsePDF(pdfDocument: pdfDocument)
        
        let date = getDate(substring: parsedPDF[0][0])
        let pid = getPid(substring: parsedPDF[0][2])
        let firstName = getFirstName(substring: parsedPDF[0][3])
        let lastName = getLastName(substring: parsedPDF[0][3])
        let sex = getSex(substring: parsedPDF[0][3])
        let homeCIF = getHomeCIF(substring: parsedPDF[0][3])
        let lastInitialIssue = getLastInitialIssue(substring: parsedPDF[0][4])
        let rankAndGrade = getRankAndGrade(substring: parsedPDF[0][2])
        let unit = getUnit(substring: parsedPDF[0][3])
        let dmos = getDMOS(substring: parsedPDF[0][3])
        let expectedClearance = getExpectedClearance(substring: parsedPDF[0][4])
        let branch = getBranch(substring: parsedPDF[0][2])
        let lastTransactionDocumentNumber = getLastTransactionDocumentNumber(substring: parsedPDF[0][5])
        let lastTransactionDTTC = getLastTransactionDTTC(substring: parsedPDF[0][6])
        let lastTransactionCIFName = getLastTransactionCIFName(substring: parsedPDF[0][5])
        let lastTransactionDate = getLastTransactionDate(substring: parsedPDF[0][6])
        
        //        let record = Record(date: <#T##Date#>, pid: <#T##String#>, firstName: <#T##String#>, lastName: <#T##String#>, sex: <#T##String#>, homeCIF: <#T##String#>, lastInitialIssue: <#T##Date#>, grade: <#T##String#>, unit: <#T##String#>, dmos: <#T##String#>, expectedClearance: <#T##String#>, branch: <#T##String#>, lastTransactionDocumentNumber: <#T##String#>, lastTransactionDTTC: <#T##String#>, lastTransactionCIFName: <#T##String#>, lastTransactionDate: <#T##Date#>, items: <#T##[Item]#>)
    }
    
    func parsePDF(pdfDocument: PDFDocument) -> [[Substring]] {
        var parsed = [[Substring]]()
        for i in 0 ..< pdfDocument.pageCount {
            guard let page = pdfDocument.page(at: i) else { continue }
            guard let pageContent = page.attributedString else { continue }
            let stuff = pageContent.string.split { $0.isNewline }
            parsed.append(stuff)
        }
        return parsed
    }
    
    private func getDate(substring: Substring) -> Date {
        let parsedSubstring = substring.split(separator: " ")
        let string = parsedSubstring[1] + " " + parsedSubstring[2]

        if let newDate = timeAndDateFormatter.date(from: String(string)) {
            return newDate
        }
        return Date(timeIntervalSinceReferenceDate: 0)
    }
    
    private func getPid(substring: Substring) -> String {
        let parsedSubstring = substring.split(separator: " ")
        return String(parsedSubstring[1])
    }
    
    private func getFirstName(substring: Substring) -> String {
        let parsedSubstring = substring.split(separator: " ")
        return String(parsedSubstring[2])
    }
    
    private func getLastName(substring: Substring) -> String {
        let parsedSubstring = substring.split(separator: " ")
        return String(parsedSubstring[1].dropLast())
    }
    
    private func getSex(substring: Substring) -> String {
        let parsedSubstring = substring.components(separatedBy: "SEX: ")
        let sections = parsedSubstring[1].components(separatedBy: "HOME ")
        let sex = sections[0]
        return String(sex)
    }
    
    private func getHomeCIF(substring: Substring) -> String {
        let parsedSubstring = substring.components(separatedBy: "CIF: ")
        let sections = parsedSubstring[1].components(separatedBy: "UNIT: ")
        let cif = sections[0]
        return String(cif)
    }
    
    private func getLastInitialIssue(substring: Substring) -> Date {
        let parsedSubstring = substring.split(separator: " ")
        let string = parsedSubstring[3]
        if let newDate = dateFormatter.date(from: String(string)) {
            return newDate
        }
        return Date(timeIntervalSinceReferenceDate: 0)
    }
    
    private func getRankAndGrade(substring: Substring) -> String {
        let parsedSubstring = substring.split(separator: " ")
        let rankAndGrade = parsedSubstring[3]
        return String(rankAndGrade)
    }
    
    private func getUnit(substring: Substring) -> String {
        let parsedSubstring = substring.components(separatedBy: "UNIT: ")
        let sections = parsedSubstring[1].components(separatedBy: "DMOS:")
        let unit = sections[0]
        return String(unit)
    }
    
    private func getDMOS(substring: Substring) -> String {
        let parsedSubstring = substring.components(separatedBy: "DMOS:")
        let dmos = parsedSubstring[1]
        return String(dmos)
    }
    
    private func getExpectedClearance(substring: Substring) -> String {
        let parsedSubstring = substring.components(separatedBy: "EXPECTED CLEARANCE:")
        let expectedClearance = parsedSubstring[1]
        return String(expectedClearance)
    }
    
    private func getBranch(substring: Substring) -> String {
        let parsedSubstring = substring.components(separatedBy: "BRANCH: ")
        let branch = parsedSubstring[1]
        return String(branch)
    }
    
    private func getLastTransactionDocumentNumber(substring: Substring) -> String  {
        let parsedSubstring = substring.components(separatedBy: "DOCUMENT NO: ")
        let sections = parsedSubstring[1].components(separatedBy: " CIF NAME:")
        let documentNumber = sections[0]
        return String(documentNumber)
    }
    
    private func getLastTransactionDTTC(substring: Substring) -> String {
        let parsedSubstring = substring.components(separatedBy: "DTTC: ")
        let sections = parsedSubstring[1].components(separatedBy: " ISSUE DATE:")
        let dttc = sections[0]
        return String(dttc)
    }
    
    private func getLastTransactionCIFName(substring: Substring) -> String {
        let parsedSubstring = substring.components(separatedBy: "CIF NAME: ")
        let cifName = parsedSubstring[1]
        return String(cifName)
    }
    
    private func getLastTransactionDate(substring: Substring) -> Date {
        let parsedSubstring = substring.components(separatedBy: "ISSUE DATE: ")
        let string = parsedSubstring[1]
        if let newDate = dateFormatter.date(from: String(string)) {
            return newDate
        }
        return Date(timeIntervalSinceReferenceDate: 0)
    }
}
