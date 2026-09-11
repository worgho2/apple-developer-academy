//
//  StudentView.swift
//  oraculo
//
//  Created by otavio on 10/02/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SwiftUI

struct StudentView: View {
    @State private var needLayoutUpdate: Bool = false
    
    @Binding public var student: Student
    
    @State private var showingSheet = false
    @State public var showingModal = false
    @State private var modalSelection = 0
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    private func deleteItem(at indexSet: IndexSet) {
        self.student.occurrences.remove(atOffsets: indexSet)
        self.needLayoutUpdate.toggle()
    }
    
    var body: some View {

        Form {
            List {
                Section(header: Text("Occurrences")) {
                    if student.occurrences.isEmpty {
                        Button(action: {
                            self.modalSelection = 0
                            self.showingModal = true
                        }) {
                            Text("Add the first occurrence")
                        }
                        
                    } else {
                        ForEach(student.occurrences) { occurrence in
                            HStack {
                                Text(occurrence.reference.text).bold()
                                Spacer()
                                Text("\(occurrence.data, formatter: self.dateFormatter)")
                            }
                        }.onDelete(perform: self.deleteItem)
                    }
                    
                }
                
                Section(header: Text("Terms")) {
                    if student.terms.isEmpty {
                        Button(action: {
                            self.modalSelection = 1
                            self.showingModal = true
                        }) {
                            Text("Add the first term")
                        }
                    } else {
                        ForEach(student.terms) { term in
                            HStack {
                                Text(term.content).bold()
                                Spacer()
                            }
                        }.onDelete(perform: self.deleteItem)
                    }
                }
                
            }
            
        }
            
        .navigationBarTitle(student.name)
        .navigationBarItems(trailing:

            Button(action: {
                self.showingSheet = true
            }) {
                Image(systemName: "plus").imageScale(.large)
            }
            .frame(width: 40, height: 40)

            .actionSheet(isPresented: $showingSheet) {
                ActionSheet(title: Text("Choose an option"), message: nil, buttons: [
                    .default(Text("Assign Occurrence"), action: {
                        self.showingModal = true
                        self.modalSelection = 0
                    }),
                    .default(Text("Print Term"), action: {
                        self.showingModal = true
                        self.modalSelection = 1
                    }),
                    .cancel()
                ])
            }

            .sheet(isPresented: $showingModal) {
                if self.modalSelection == 0 {
                    AssignOccurrenceView(student: self.$student, showingModal: self.$showingModal)
                } else if self.modalSelection == 1 {
                    PrintTermView(student: self.$student, showingModal: self.$showingModal)
                }
            }

        )
    }
}

struct StudentView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
