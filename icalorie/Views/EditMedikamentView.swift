//
//  EditMedikamentView.swift
//  icalorie
//
//  Created by Jannik Scheider on 27.04.24.
//

import SwiftUI

struct EditMedikamentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var medikament: FetchedResults<Medikament>.Element
    
    @State private var name = ""
    @State private var date = Date()
    
    var body: some View {
        Form {
            Section() {
                TextField("\(medikament.name!)", text: $name)
                    .onAppear {
                        name = medikament.name!
                        date = medikament.date!
                    }
                DatePicker("Haltbarkeitsdatum", selection: $date, displayedComponents: .date)
                            
                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController().editMedikament(medikament: medikament, name: name, date: date, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}
