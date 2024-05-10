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
    @FetchRequest(sortDescriptors: []) var medikamente: FetchedResults<Medikament>

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                List {
                    ForEach(medikamente) { medikament in
                        NavigationLink(value: medikament){
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
                .navigationDestination(for: Medikament.self){ m in
                    EditMedikamentView(medikament: m)
                }
            }
            .navigationTitle("Medikamente")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        EingabeMedikamentView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    // Deletes medikament at the current offsets
    private func deleteMedikament(offsets: IndexSet) {
        withAnimation {
            offsets.map { medikamente[$0] }
            .forEach(managedObjContext.delete)

            // Saves to our database
            DataController().save(context: managedObjContext)
        }
    }
}

#Preview {
    ContentView()
}
