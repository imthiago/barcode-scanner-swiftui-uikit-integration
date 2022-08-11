//
//  ScannerView.swift
//  BarcodeScanner
//
//  Created by Thiago Oliveira on 10/08/22.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {

    // MARK: - Bindable variables
    @Binding var scannedCode: String
    @Binding var alertItem: AlertItem?

    func makeUIViewController(context: Context) -> ScannerViewController {
        ScannerViewController(delegate: context.coordinator)
    }

    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView: self)
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView(scannedCode: .constant("123456"), alertItem: .constant(nil))
    }
}
