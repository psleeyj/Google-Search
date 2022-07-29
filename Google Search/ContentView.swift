//
//  ContentView.swift
//  Google Search
//
//  Created by 이소은 on 2022/07/28.
//

import SwiftUI

struct ContentView: View {
    @State private var entries = [Entry]()
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            List(entries) { entry in
                Link(destination: URL(string: entry.link)!, label: {
                    Text(entry.title)
                })
            }
            .navigationTitle("Corn Dogs")
        }
        .onAppear(perform: {
        })
        .alert(isPresented: $showingAlert, content: {
            Alert(title: Text("Loading Error"),
                  message: Text("There was a problem loading the data"),
                  dismissButton: .default(Text("OK")))
        })
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Entry: Identifiable {
    let id: UUID
    let title: String
    let link: String
}




