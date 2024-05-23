//
//  ScanningView.swift
//  icalorie
//
//  Created by Jannik Scheider on 29.04.24.
//

import SwiftUI


import SwiftUI
import VisionKit
struct ScanningView: View {
    @EnvironmentObject var vm: AppViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                switch vm.dataScannerAccessStatus {
                case .scannerAvailable:
                    mainView
                        .onChange(of: vm.shouldDismissScanner) { shouldDismiss in
                            if shouldDismiss {
                                self.presentationMode.wrappedValue.dismiss() // Schließen der Ansicht
                                vm.shouldDismissScanner = false // Zurücksetzen des Flags
                            }
                        }
                case .cameraNotAvailable:
                    Text("Ihr Gerät verfügt nicht über eine Kamera.")
                case .scannerNotAvailable:
                    Text("Ihr Gerät unterstützt das Scannen von Barcodes mit dieser App nicht.")
                case .cameraAccessNotGranted:
                    Text("Bitte gewähren Sie in den Einstellungen Zugriff auf die Kamera.")
                case .notDetermined:
                    Text("Kamerazugriff wird angefordert...")
                }
            }
        }
    }

    private var mainView: some View {
        ZStack{
            DataScannerView(
                recognizedItems: $vm.recognizedItems,
                recognizedDataType: vm.recognizedDataType,
                recognizesMultipleItems: false)
            .background(Color.gray.opacity(0.3))
            .ignoresSafeArea()
            .id(vm.dataScannerAccessStatus.hashValue)
            .onAppear {
                print("Barcode scanning view is active")
            }
            
            VStack {
                Spacer()
                Button("Aktion ausführen") {
                    // Führe hier die gewünschte Aktion aus
                    print("Button wurde gedrückt")
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
            }
        }
    }

}

