//
//  BarcodeScannerViewModel.swift
//  BarcodeScanner
//
//  Created by Thiago Oliveira on 10/08/22.
//

import SwiftUI

final class BarcodeScannerViewModel: ObservableObject {

    // MARK: - Published properties
    @Published var scannedCode: String = ""
    @Published var alertItem: AlertItem?

    // MARK: - Computed properties
    var statusText: String {
        return scannedCode.isEmpty ? "Not Yet Scanned" : scannedCode
    }

    var statusTextColor: Color {
        scannedCode.isEmpty ? .red : .green
    }
}
