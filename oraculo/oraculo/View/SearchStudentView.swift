//
//  SearchStudentView.swift
//  oraculo
//
//  Created by otavio on 05/02/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SwiftUI

struct SearchStudentView: View {
    @State private var needLayoutUpdate: Bool = false
    
    //studentModel
    @ObservedObject public var studentModel = StudentModel()
    
    //SearchBar
    @State private var searchText = ""
    
    //Picker
    @State public var pickerSelection = "All"
    @State public var pickerCategories = ["All", "Name",  "Class", "Grade"]

    var body: some View {

        NavigationView {
            VStack {
                SearchBarView(searchText: $searchText, pickerSelection: $pickerSelection, pickerCategories: $pickerCategories)
                
                List(filterStudents(studentModel.students)) { student in
                    NavigationLink(destination:
                        StudentView(student: self.$studentModel.students[self.studentModel.students.firstIndex(where: { $0.id == student.id })!])
                    ) {
                        HStack {
                            Image("avatar")
                                .resizable()
                                .clipShape(Circle())
                                .shadow(radius: 10)
                                .frame(width: 60, height: 60)
                            VStack(alignment: .leading) {
                                Text("\(student.name)").bold()
                                Spacer()
                                Group {
                                    Text("Grade: ") + Text("\(student.grade)").bold() + Text(" Class: ") + Text("\(student.className)").bold()
                                }
                                .font(.caption)
                            }
                            .padding(.vertical)
                        }
                    }
                    
                }

                .navigationBarTitle(Text("Search Students"))
                .navigationBarItems(trailing:
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear").imageScale(.large)
                        .frame(width: 40, height: 40)
                    }
                )
                .resignKeyboardOnDragGesture()
            }
        }
    }
    
    private func filterStudents(_ s: [Student]) -> [Student] {
        
        switch self.pickerSelection {
            case "All":
                return s.filter( { $0.name.lowercased().contains(searchText.lowercased()) || $0.className.lowercased().contains(searchText.lowercased()) || String($0.grade).lowercased().contains(searchText.lowercased()) || searchText == "" } )
            case "Name":
                return s.filter( { $0.name.lowercased().contains(searchText.lowercased()) || searchText == "" } )
            case "Class":
                return s.filter( { $0.className.lowercased().contains(searchText.lowercased()) || searchText == "" } )
            case "Grade":
                return s.filter( { String($0.grade).lowercased().contains(searchText.lowercased()) || searchText == "" } )
            default:
                return s
        }
    }
}

struct SearchStudentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchStudentView()
                .environment(\.colorScheme, .dark)
            SearchStudentView()
                .environment(\.colorScheme, .light)
        }
    }
}
