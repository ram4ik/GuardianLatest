//
//  ContentView.swift
//  GuardianLatest
//
//  Created by Ramill Ibragimov on 08.12.2019.
//  Copyright © 2019 Ramill Ibragimov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var status = ""
    @State var items = [Item]()
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(self.items, id: \.id) { item in
                        NavigationLink(destination: WebView(url: item)) {
                            ItemView(item: item)
                        }
                    }
                }.onAppear() {
                    self.loadPages()
                }
                HStack {
                    Text(self.status)
                        .opacity(0.1)
                        .padding()
                    Spacer()
                    Button(action: {
                        self.loadPages()
                    }) {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.title)
                            .padding()
                    }
                }
                
            }.tabItem {
                Image(systemName: "list.dash")
                    .font(.title)
            }.navigationBarTitle(Text("Latest News"))
            
        }
    }
    
    func loadPages() {
        NetworkManager.fetchAllPages { pages in
            DispatchQueue.main.async {
                self.items = [Item]()
                self.items.append(contentsOf: pages.response!.results)
                self.status = (pages.response?.status)!
            }
        }
        print(self.items.count)
    }
}

struct ItemView: View {
    @State var item: Item
    var body: some View {
        VStack {
            Text("\(item.webTitle ?? "n/a")")
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
