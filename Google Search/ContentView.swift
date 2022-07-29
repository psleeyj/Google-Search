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
            queryAPI()
        })
        .alert(isPresented: $showingAlert, content: {
            Alert(title: Text("Loading Error"),
                  message: Text("There was a problem loading the data"),
                  dismissButton: .default(Text("OK")))
        })
    }
    func queryAPI() {
        let apiKey = "?rapidapi-key = 758f477fdcmsh2b78f5fdd0bf86bp1ccc3fjsnbd45cb1f4332"
        let query = "https://google-search3.p.rapidapi.com/api/v1/search/q=corn+dog&num=100?rapidapi-key="
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                let contents = json["results"].arrayValue
                for item in contents {
                    let title = item["title"].stringValue
                    let link = item["link"].stringValue
                    let entry = Entry(title: title, link: link)
                    entries.append(entry)
                }
                return
            }
        }
        showingAlert = true
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Entry: Identifiable {
    let id = UUID()
    let title: String
    let link: String
}




