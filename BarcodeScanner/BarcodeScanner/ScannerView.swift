//
//  ScannerView.swift
//  BarcodeScanner
//
//  Created by Thiago Oliveira on 10/08/22.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> ScannerViewController {
        ScannerViewController(delegate: context.coordinator)
    }

    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    final class Coordinator: NSObject, ScannerViewControllerDelegate {
        func didFind(barcode: String) {
            print(barcode)
        }

        func didSurface(error: CameraError) {
            print(error.rawValue)
        }
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
