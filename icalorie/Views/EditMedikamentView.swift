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
                TextField("Medikamentname", text: $name)
                    .onAppear {
                        name = medikament.name ?? ""
                        date = medikament.date ?? Date()
                    }
                DatePicker("Haltbarkeitsdatum", selection: $date, displayedComponents: .date)
                            
                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController.shared.editMedikament(medikament: medikament, name: name, date: date, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    let context = DataController.shared.container.viewContext
    let medikament = Medikament(context: context)
    medikament.name = "Beispielmedikament"
    medikament.date = Date()
    medikament.id = UUID()

    return EditMedikamentView(medikament: medikament)
        .environment(\.managedObjectContext, context)
}

struct EditMedikamentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = DataController.shared.container.viewContext
        let medikament = Medikament(context: context)
        medikament.name = "Beispielmedikament"
        medikament.date = Date()
        medikament.id = UUID()

        return EditMedikamentView(medikament: medikament)
            .environment(\.managedObjectContext, context)
    }
}
