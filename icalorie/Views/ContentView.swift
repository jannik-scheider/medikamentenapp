//
//  ContentView.swift
//  icalorie
//
//  Created by Jannik Scheider on 27.04.24.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: []) var medikament: FetchedResults<Medikament>
        
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(medikament) { medikament in
                        NavigationLink(destination: EditMedikamentView(medikament: medikament)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(medikament.name!)
                                        .bold()
                                }
                                Spacer()
                            }
                        }
                    }
                    .onDelete(perform: deleteMedikament)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Medikamente")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: EingabeMedikamentView()) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .navigationViewStyle(.stack) // Removes sidebar on iPad
    }
    
    // Deletes medikament at the current offset
    private func deleteMedikament(offsets: IndexSet) {
        withAnimation {
            offsets.map { medikament[$0] }
            .forEach(managedObjContext.delete)
            
            // Saves to our database
            DataController().save(context: managedObjContext)
        }
    }
}

#Preview {
    ContentView()
}
