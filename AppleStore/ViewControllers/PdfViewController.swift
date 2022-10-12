//
//  PdfViewController.swift
//  AppleStore
//
//  Created by muxammed on 12.10.2022.
//

import PDFKit
import UIKit

/// PdfViewController - экран для показа локального pdf файла
class PdfViewController: UIViewController {
    
    let pdfView = PDFView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(pdfView)
        view = pdfView
        
        if let path = Bundle.main.path(forResource: "dz", ofType: "pdf") {
                    if let pdfDocument = PDFDocument(url: URL(fileURLWithPath: path)) {
                        pdfView.displayMode = .singlePageContinuous
                        pdfView.autoScales = true
                        pdfView.displayDirection = .vertical
                        pdfView.document = pdfDocument
                    }
                }
    }
}
