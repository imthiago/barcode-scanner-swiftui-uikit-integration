//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by Thiago Oliveira on 10/08/22.
//

import SwiftUI

struct BarcodeScannerView: View {
    
    // MARK: - Private properties
    @State private var scannedCode: String = ""

    var body: some View {
        NavigationView {
            VStack {
                ScannerView(scannedCode: $scannedCode)
                    .frame(maxWidth: .infinity, maxHeight: 300)

                Spacer()
                    .frame(height: 60)

                Label("Scanned barcode:", systemImage: "barcode.viewfinder")
                    .font(.title)

                Text(scannedCode.isEmpty ? "Not Yet Scanned" : scannedCode)
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(scannedCode.isEmpty ? .red : .green)
                    .padding()
            }
            .navigationTitle("Barcode Scanner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScannerView()
    }
}
