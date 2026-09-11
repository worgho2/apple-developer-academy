//
//  InitialTabView.swift
//  DonutForget
//
//  Created by João Conrado Santana de Lima Dembiski on 11/02/20.
//  Copyright © 2020 João Conrado Santana de Lima Dembiski. All rights reserved.
//

import SwiftUI
import Combine

struct InitialTabView: View {
    @ObservedObject public var taskModel = TaskModel()
    
    @State public var selectedTab = 0
    
    var body: some View {
        
        TabView(selection: self.$selectedTab, content: {
            
            TasksView(tasks: self.$taskModel.wayneTasks, selectedTab: self.$selectedTab)
                .tabItem {
                    Image(systemName: "globe")
                    Text("Wayne")
            }.tag(0)
            
            TasksView(tasks: self.$taskModel.batmanTasks, selectedTab: self.$selectedTab)
                .tabItem {
                    Image(systemName: "moon.fill")
                    Text("Batman")
            }.tag(1)
        })
        .accentColor(.yellow)
    }
}


struct InitialTabView_Previews: PreviewProvider {
    static var previews: some View {
        InitialTabView()
    }
}
