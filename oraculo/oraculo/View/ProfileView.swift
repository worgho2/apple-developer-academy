//
//  ProfileView.swift
//  oraculo
//
//  Created by otavio on 13/02/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @State var name: String = Model.instance.currentUser.name
    
    @State var email: String = Model.instance.currentUser.email
    
    var body: some View {
        Form {
            Section(header: Text("Info")) {
                HStack {
                    Image("avatar")
                        .resizable()
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .frame(width: 70, height: 70)
                    VStack(alignment: .leading) {
                        Text("Access Level:").bold() + Text("\(Model.instance.currentUser.accessLevel.rawValue)")
                        Text("Id: ").bold() + Text("\(Model.instance.currentUser.id)")
                    }
                }
                
            }
            Section(header: Text("Name")) {
                TextField(name, text: $name)
            }
            Section(header: Text("Email")) {
                TextField(email, text: $email)
            }
            
            .navigationBarTitle(Text("Edit Profile"))
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
