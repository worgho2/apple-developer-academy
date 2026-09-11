import SwiftUI

struct NewTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding public var tasks: [Task]
    
    @State public var taskPriority: TaskPriority = .no
    @State public var taskNameText: String = ""

    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Your Task...", text: $taskNameText)
                }
                
                Section(header: Text("Priority")) {
                    Picker("Priority", selection: self.$taskPriority) {
                        ForEach(TaskPriority.allCases, id: \.self) {
                            Text($0.rawValue).tag($0)
                        }
                    }
                    .pickerStyle( SegmentedPickerStyle())
                }
            }
            .navigationBarTitle(Text("New Task"), displayMode: .inline)
            .navigationBarItems(leading:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel")
                    }
                , trailing:
                    Button("Save") {
                        self.onSave()
                    }
                    .disabled(taskNameText.isEmpty)
            )
        }
        .foregroundColor(.yellow)
    }
    
    private func onSave() {
        self.tasks.append(Task(name: self.taskNameText, priority: self.taskPriority))
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView(tasks: .constant([]))
    }
}
