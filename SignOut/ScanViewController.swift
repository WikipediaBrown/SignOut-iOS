//
//  ScanViewController.swift
//  SignOut
//
//  Created by Wikipedia Brown on 7/27/19.
//  Copyright © 2019 IamGoodBad. All rights reserved.
//

import PDFKit

class ScanViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
//        let document = PDFDocument(url: <#T##URL#>)
    }
    
    func scandocument(pdfDocument: PDFDocument) {
        
        let pageCount = pdfDocument.pageCount
        let documentContent = NSMutableAttributedString()
        
        for i in 1 ..< pageCount {
            guard let page = pdfDocument.page(at: i) else { continue }
            guard let pageContent = page.attributedString else { continue }
            documentContent.append(pageContent)
        }
        
        print(documentContent.string)
    }
}
