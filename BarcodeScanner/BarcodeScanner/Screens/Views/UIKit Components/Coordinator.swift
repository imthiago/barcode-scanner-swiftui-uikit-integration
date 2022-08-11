//
//  Coordinator.swift
//  BarcodeScanner
//
//  Created by Thiago Oliveira on 10/08/22.
//

import Foundation

final class Coordinator: NSObject, ScannerViewControllerDelegate {
    private let scannerView: ScannerView

    init(scannerView: ScannerView) {
        self.scannerView = scannerView
    }

    func didFind(barcode: String) {
        scannerView.scannedCode = barcode
    }

    func didSurface(error: CameraError) {
        switch error {
        case .invalidDeviceInput:
            scannerView.alertItem = AlertContext.invalidDeviceInput
        case .invalidScannedValue:
            scannerView.alertItem = AlertContext.invalidScannedType
        }
    }
}
