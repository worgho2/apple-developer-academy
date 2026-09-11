//
//  TaskEditView.swift
//  DonutForget
//
//  Created by João Conrado Santana de Lima Dembiski on 11/02/20.
//  Copyright © 2020 João Conrado Santana de Lima Dembiski. All rights reserved.
//

import SwiftUI

struct TaskEditView: View {
    @Binding var task: Task

    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField(self.task.name, text: self.$task.name)
            }
            Section(header: Text("State")) {
                Toggle("Completed", isOn: self.$task.completed)
            }
        }
        .navigationBarTitle(Text("Edit Task"), displayMode: .inline)
    }
}
  
struct TaskEditView_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditView(task: .constant(Task(name: "Task Name", priority: .high)))
    }
}

