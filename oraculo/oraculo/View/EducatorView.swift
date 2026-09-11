//
//  EducatorView.swift
//  oraculo
//
//  Created by otavio on 12/02/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SwiftUI
import Combine

struct EducatorView: View {
    @ObservedObject public var educatorsModel = EducatorModel()
    
    //SearchBar
    @State private var searchText = ""
    
    //Picker
    @State public var pickerSelection = "All"
    @State public var pickerCategories = ["All", "Name",  "Email", "AccessLevel"]
    
    var body: some View {
        VStack {

            SearchBarView(searchText: $searchText, pickerSelection: $pickerSelection, pickerCategories: $pickerCategories)
            
            List {
                ForEach(self.filterEducators(self.educatorsModel.educators)) { educator in
                    HStack {
                        Image("avatar")
                            .resizable()
                            .clipShape(Circle())
                            .shadow(radius: 10)
                            .frame(width: 60, height: 60)
                        VStack(alignment: .leading) {
                            Text("\(educator.name)").bold()
                            Text("\(educator.email)").font(.footnote)
                        }
                        Picker("", selection: self.$educatorsModel.educators[self.educatorsModel.educators.firstIndex(where: {$0.id == educator.id})!].accessLevel) {
                            ForEach(AccessLevel.allCases, id: \.self) { Text($0.rawValue).tag($0) }
                        }.disabled(educator.id == Model.instance.currentUser.id)
                    }
                }
            }
        }
        .navigationBarTitle(Text("Educators"))
        .resignKeyboardOnDragGesture()
    }
    
    private func filterEducators(_ e: [Educator]) -> [Educator] {
        
        switch self.pickerSelection {
            case "All":
                return e.filter({ $0.name.lowercased().contains(searchText.lowercased()) || $0.email.lowercased().contains(searchText.lowercased()) || $0.accessLevel.rawValue.lowercased().contains(searchText.lowercased()) || searchText == "" })
            case "Name":
                return e.filter({ $0.name.lowercased().contains(searchText.lowercased()) || searchText == "" })
            case "Email":
                return e.filter({ $0.email.lowercased().contains(searchText.lowercased()) || searchText == "" })
            case "AccessLevel":
                return e.filter({ $0.accessLevel.rawValue.lowercased().contains(searchText.lowercased()) || searchText == "" })
            default:
                return e
        }
    }
    
}

struct EducatorView_Previews: PreviewProvider {
    static var previews: some View {
        EducatorView()
    }
}
