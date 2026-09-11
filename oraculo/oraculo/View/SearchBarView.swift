//
//  SearchBarView.swift
//  oraculo
//
//  Created by otavio on 13/02/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SwiftUI

struct SearchBarView: View {
    @State private var showCancelButton: Bool = false
    
    //SearchBar
    @Binding public var searchText: String
    
    //Picker
    @Binding public var pickerSelection: String
    @Binding public var pickerCategories: [String]
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")

                    TextField("search", text: $searchText, onEditingChanged: { isEditing in
                        self.showCancelButton = true
                    }).foregroundColor(.primary)

                    Button(action: {
                        self.searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .foregroundColor(.secondary)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10.0)

                if showCancelButton  {
                    Button("Cancel") {
                            UIApplication.shared.endEditing(true)
                            self.searchText = ""
                            self.showCancelButton = false
                            self.pickerSelection = self.pickerCategories[0]
                    }
                    .foregroundColor(Color(.systemBlue))
                }
            }
            .padding(.horizontal)
            .navigationBarHidden(showCancelButton)
            
            Picker("", selection: $pickerSelection) {
                ForEach(self.pickerCategories, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
//        SearchBarView()
        Text("")
    }
}
