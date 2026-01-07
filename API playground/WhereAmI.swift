//
//  WhereAmI.swift
//  API playground
//
//  Created by John Sencion on 12/19/25.
//

import SwiftUI

//https://api.myip.com
struct WhereAmI: View {
    var object:ip = .init()
    @State var userAdress: String = ""
    @State var country: String = ""
    @State var cc: String = ""
    var body: some View {
        Text(userAdress)
        Text(country)
Text(cc)
        Button("THIS WILL GET YOUR IP") {
            var b = object.makeRequest(resource: "")
            global.session.dataTask(with: b) { data, urlr, e in
                if let e = e {
                    print(e)
                }
                print(data)
                if let data = data, let data = try? JSONSerialization.jsonObject(with: data) as? [String: Any]  {
                    print(data)
                    userAdress = data["ip"] as? String ?? userAdress
                    country = data["country"] as? String ?? country
                    cc = data["cc"] as? String ?? cc
                }
            }.resume()
        }
    }
    struct ip:api {
        var token: String = ""
        
        var url : String = "https://api.myip.com:443"
        var apiModifier:String = ""
        init(){}
    }

}

#Preview {
    WhereAmI()
}
