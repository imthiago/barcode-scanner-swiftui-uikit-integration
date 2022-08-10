//
//  ScannerViewController.swift
//  BarcodeScanner
//
//  Created by Thiago Oliveira on 10/08/22.
//

import UIKit
import AVFoundation

protocol ScannerViewControllerDelegate: AnyObject {
    func didFind(barcode: String)
}

final class ScannerViewController: UIViewController {

    // MARK: - Properties
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?

    // MARK: - Delegate
    weak var delegate: ScannerViewControllerDelegate?

    // MARK: - Initialization
    init(delegate: ScannerViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private functions
    private func setupCaptureSession() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }

        let videoInput: AVCaptureDeviceInput

        do {
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            return
        }

        let metaDataOutput = AVCaptureMetadataOutput()

        if captureSession.canAddOutput(metaDataOutput) {
            captureSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [.ean8, .ean13]
        } else {
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)

        captureSession.startRunning()
    }
}

extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else {
            return
        }

        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else {
            return
        }

        guard let barcode = machineReadableObject.stringValue else {
            return
        }

        delegate?.didFind(barcode: barcode)
    }
}
