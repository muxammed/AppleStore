//
//  PdfViewController.swift
//  AppleStore
//
//  Created by muxammed on 12.10.2022.
//

import PDFKit
import UIKit

/// PdfViewController - экран для показа локального pdf файла
final class PdfViewController: UIViewController {
    
    // MARK: - Visual Components
    let pdfView = PDFView()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Private Methods
    private func configure() {
        view.addSubview(pdfView)
        view = pdfView
        
        if let path = Bundle.main.path(forResource: Constants.dz, ofType: Constants.pdf) {
            if let pdfDocument = PDFDocument(url: URL(fileURLWithPath: path)) {
                pdfView.displayMode = .singlePageContinuous
                pdfView.autoScales = true
                pdfView.displayDirection = .vertical
                pdfView.document = pdfDocument
            }
        }
    }
}
