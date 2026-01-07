//
//  WhereAmI.swift
//  API playground
//
//  Created by John Sencion on 12/19/25.
//

import SwiftUI

//https://api.myip.com
struct WhereAmI: View {
    var objecta:ip = .init()
    var objectb:ipcountry = .init()
    @State var userAdress: String = ""
    @State var country: String = ""
    @State var cc: String = ""
    var body: some View {
        Text("IPAdress - \(userAdress)")
        Text("countrty - \(country)")
        Text("country ISO code - \(cc)")
        Button("THIS WILL GET YOUR IP") {
            var b = objecta.makeRequest(resource: "")
            global.session.dataTask(with: b) { data, urlr, e in
                if let e = e {
                    print(e)
                }
//                print(data)
                if let data = data, let data = try? JSONSerialization.jsonObject(with: data) as? [String: Any]  {
                    print(data)
                    userAdress = data["ip"] as? String ?? userAdress
                    country = data["country"] as? String ?? country
//                    cc = data["cc"] as? String ?? cc
                    if let adress = data["ip"] as? String {
                        var bb = objectb.makeRequest(resource: adress)
                        global.session.dataTask(with: bb) { data, urlr, e in
                            if let e = e {
                                print(e)
                            }
//                        print(data)
                            if let data = data, let data = try? JSONSerialization.jsonObject(with: data) as? [String: Any]  {
                                print(data)
                                cc = data["country"] as? String ?? cc
//                            userAdress = data["ip"] as? String ?? userAdress
//                            country = data["country"] as? String ?? country
//                            cc = data["cc"] as? String ?? cc
                            }
                        }.resume()
                    }
                }
            }.resume()
        }
    }
    
    struct ipcountry:api {
        var token: String = ""
        
        var url : String = "https://api.country.is:443"
        var apiModifier:String = ""
        init(){}
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
