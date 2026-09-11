//
//  AssignOccurrenceView.swift
//  oraculo
//
//  Created by otavio on 11/02/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SwiftUI

struct AssignOccurrenceView: View {
    
    @State private var occurrenceReferences = Model.instance.occurrenceReferences
       
    @Binding public var student: Student
    
    @Binding public var showingModal: Bool
    @State private var showingAlert: Bool = false
    @State private var occurrenceDate = Date()
    
    var body: some View {
        NavigationView {

            Form {
                
                Section(header: Text("Occurrences")) {
                    List(occurrenceReferences) { reference in
                        HStack { 
                            Toggle(isOn: self.$occurrenceReferences[self.occurrenceReferences.firstIndex(where: { $0.id == reference.id })!].isActive) {
                                Text("\(reference.text)")
                            }
                        }
                    }
                }
                
                Section(header: Text("Date")) {
                    DatePicker(selection: $occurrenceDate, in: ...Date(), displayedComponents: .date) {
                        Text("Select a date")
                    }
                }
                
            }
                
            .navigationBarTitle(Text("Assign Occurrence"), displayMode: .inline)
            .navigationBarItems(leading:
                
                Button(action: {
                    self.showingModal = false
                }) {
                    Text("Cancel")
                }
                .frame(height: 40)
                
            , trailing:
                
                Button(action: {
                    self.onDone()
                }) {
                    Text("Done")
                }
                .frame(height: 40)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error"), message: Text("Select at least one occurrence"), dismissButton: .default(Text("Ok")))
                }
                
            )

        }
    }
    
    private func onDone() {
        if !occurrenceReferences.map({ $0.isActive }).contains(true) {
            showingAlert = true
            return
        }
        
        for (index, item) in occurrenceReferences.map({ $0.isActive }).enumerated() {
            if item {
                let occurrence = Occurrence(reference: occurrenceReferences[index], data: occurrenceDate)
                
                Model.instance.currentUser.assignOccurrence(to: student, occurrence: occurrence)
            }
            
        }
        
        self.resetOccurrenceReferencesState()
        showingModal = false
    }
    
    private func resetOccurrenceReferencesState() {
        occurrenceReferences.forEach { $0.isActive = false }
    }
}

struct AssignOccurrenceView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
