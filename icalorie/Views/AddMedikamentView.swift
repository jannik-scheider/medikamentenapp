//
//  AddMedikamentView.swift
//  icalorie
//
//  Created by Jannik Scheider on 27.04.24.
//

import SwiftUI

struct AddMedikamentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var date = Date()
    
    var body: some View {
            Form {
                Section() {
                    TextField("Medikament name", text: $name)
                    
                    DatePicker("Haltbarkeitsdatum", selection: $date, displayedComponents: .date)
                
                    HStack {
                        Spacer()
                        Button("Submit") {
                            DataController.shared.addMedikament(
                                name: name,
                                date: date,
                                context: managedObjContext)
                            dismiss()
                        }
                        .disabled(name.isEmpty || Calendar.current.isDateInToday(date))  // Button ist deaktiviert, wenn kein Name oder das heutige Datum ausgewählt ist

                        Spacer()
                    }
                }
        }
    }
}

#Preview {
    AddMedikamentView()
}
