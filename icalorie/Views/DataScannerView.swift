//
//  DataScannerView.swift
//  icalorie
//
//  Created by Jannik Scheider on 29.04.24.
//

import Foundation
import SwiftUI
import VisionKit


struct DataScannerView: UIViewControllerRepresentable {
    @Binding var recognizedItems: [RecognizedItem]
    let recognizedDataType: DataScannerViewController.RecognizedDataType
    let recognizesMultipleItems: Bool
    @EnvironmentObject var vm: AppViewModel

    func makeUIViewController(context: Context) -> DataScannerViewController {
        let vc = DataScannerViewController(
            recognizedDataTypes: [.barcode(symbologies: [.code39, .code128, .qr])],
            qualityLevel: .balanced,
            recognizesMultipleItems: recognizesMultipleItems,
            isGuidanceEnabled: true,
            isHighlightingEnabled: true
        )
        return vc
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        uiViewController.delegate = context.coordinator
        try? uiViewController.startScanning()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedItems: $recognizedItems, viewModel: vm) // Pass the ViewModel to the Coordinator
    }

    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        @Binding var recognizedItems: [RecognizedItem]
        var viewModel: AppViewModel // ViewModel Referenz

        init(recognizedItems: Binding<[RecognizedItem]>, viewModel: AppViewModel) {
            self._recognizedItems = recognizedItems
            self.viewModel = viewModel
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            recognizedItems.append(contentsOf: addedItems)
            if let barcodeItem = addedItems.first(where: { if case .barcode(_) = $0 { return true } else { return false } }),
               case .barcode(let barcode) = barcodeItem {
                viewModel.lastScannedBarcode = barcode.payloadStringValue
                viewModel.shouldDismissScanner = true  // Setzen des Flags, um die Ansicht zu schließen
            }
            print("New barcodes recognized")
        }
    }


}
