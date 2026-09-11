//
//  SettingsView.swift
//  oraculo
//
//  Created by otavio on 11/02/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @State private var needLayoutUpdate: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("Profile")) {
                HStack {
                    NavigationLink(destination: ProfileView()) {
                        Image("avatar")
                               .resizable()
                               .clipShape(Circle())
                               .shadow(radius: 10)
                               .frame(width: 70, height: 70)
                        VStack(alignment: .leading) {
                            Text("\(Model.instance.currentUser.name)").bold()
                            Text("\(Model.instance.currentUser.email)").font(.footnote)
                        }
                    }
                }
            }
            
            if Model.instance.currentUser.accessLevel == .admin {
                Section(header: Text("Admin Features")) {
                    HStack {
                        NavigationLink(destination: EducatorView()) {
                            Text("Educator's access level")
                        }
                    }
                }
            }
        }.onAppear(perform: self.updateScreen)
            
        .navigationBarTitle(Text("Settings"))
    }
    
    func updateScreen() {
        self.needLayoutUpdate.toggle()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
