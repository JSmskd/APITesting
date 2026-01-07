//
//  ContentView.swift
//  API playground
//
//  Created by John Sencion on 12/16/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationLink {
            NameDay()
        } label: {
            Text("name day")
        }
        NavigationLink {
            WhereAmI()
            //            <#code#>
        } label: {
            Text("Where am I")
        }
        
    }
}

#Preview {
    ContentView()
}
