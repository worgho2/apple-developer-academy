import SwiftUI

struct TasksView: View {
    @Binding public var tasks: [Task]
    @Binding public var selectedTab: Int
    
    @State public var showingModal: Bool = false
    @State public var modalSelection: TaskPriority = .no
    
    var body: some View {
        
        NavigationView {
            
            Form {
                ForEach(TaskPriority.allCases, id: \.self) { priority in
                    Section(header: Text("\(priority.rawValue) priority")) {
                        
                        if self.filterTaskByPriority(priority).isEmpty {
                            Button(action: {
                                self.showingModal = true
                                self.modalSelection = priority
                            }) {
                                Text("Add a \(priority.rawValue) priority task here")
                            }
                        } else {
                            ForEach(self.filterTaskByPriority(priority)) { task in
                                HStack {
                                    Button(action: {}) {
                                        Image(systemName: task.completed ? "checkmark.circle" : "circle")
                                    }
                                    .frame(width: 30, height: 30, alignment: .center)
                                    .accentColor(.yellow)
                                    
                                    NavigationLink(destination: TaskEditView(task: self.$tasks[self.tasks.firstIndex(where: {$0.id == task.id})!])) {
                                        Text("\(task.name)")
                                        .strikethrough(task.completed)
                                    }
                                    
                                    Spacer()
                                }
                            }
//                            Unica coisa que precisa fazer :)
//                            .onMove(perform: <#T##Optional<(IndexSet, Int) -> Void>##Optional<(IndexSet, Int) -> Void>##(IndexSet, Int) -> Void#>)
//                            .onDelete(perform: <#T##Optional<(IndexSet) -> Void>##Optional<(IndexSet) -> Void>##(IndexSet) -> Void#>)
                        }
                    }
                }
            }
                
            .listStyle(GroupedListStyle())
            .navigationBarTitle(selectedTab == 0 ? "Batman Missions 🦇" : "Wayne Enterprises 💼", displayMode: .large)
            .navigationBarItems(leading:
                    EditButton()
                , trailing:
                    Button(action: {
                        self.showingModal = true
                        self.modalSelection = .no
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                    .foregroundColor(.yellow)
                    .font(.system(size: 21, weight: .light))
                    .frame(width: 40, height: 40, alignment: .center)
            )
            .accentColor(.yellow)
            .sheet(isPresented: $showingModal ) {
                NewTaskView(tasks: self.$tasks, taskPriority: self.modalSelection)
            }
        }
        
    }
    
    private func filterTaskByPriority(_ p: TaskPriority) -> [Task] {
        switch p {
        case .no:
            return self.tasks.filter({ $0.priority == .no })
        case .low:
            return self.tasks.filter({ $0.priority == .low })
        case .medium:
            return self.tasks.filter({ $0.priority == .medium })
        case .high:
            return self.tasks.filter({ $0.priority == .high })
        }
    }
    
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView(tasks: .constant([
            Task(name: "Task_no_Priority", priority: .no),
            Task(name: "Task_low_Priority", priority: .low),
            Task(name: "Task_medium_Priority", priority: .medium),
            Task(name: "Task_high_Priority", priority: .high),
        ]), selectedTab: .constant(0))
    }
}

