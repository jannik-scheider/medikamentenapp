//
//  EingabeMedikamentView.swift
//  icalorie
//
//  Created by Jannik Scheider on 27.04.24.
//

import SwiftUI

struct EingabeMedikamentView: View {
    
    @StateObject private var vm = AppViewModel()
    
    var body: some View {
        VStack {
            if let lastScannedBarcode = vm.lastScannedBarcode {
                Text("Zuletzt gescannter Barcode: \(lastScannedBarcode)")
            } else {
                Text("Noch kein Barcode gescannt.")
            }
            NavigationLink(destination: ScanningView().environmentObject(vm)
                .task {
                    await vm.requestDataScannerAccessStatus()
                }) {
                    Text("Start Barcode Scanning")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            
            NavigationLink(destination: AddMedikamentView()) {
                Text("Manuelle Eingabe")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .buttonStyle(.borderedProminent)
            .toolbarRole(.editor)
        }
        .padding()
        .navigationTitle("Eingabemöglichkeit")
        .toolbarRole(.editor)
    }
}
