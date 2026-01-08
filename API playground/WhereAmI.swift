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
    var objectb:ipcode = .init()
    var objectc:codecountry = .init()
    @State var userAdress: String = ""
    @State var country: String = ""
    @State var cc: String = ""
    var body: some View {
        Text("IPAdress - \(userAdress)")
        Text("country ISO code - \(cc)")
        Text("countrty - \(country)")
        Button("THIS WILL GET YOUR IP") {
            var b = objecta.makeRequest(resource: "")
            global.session.dataTask(with: b) { data, urlr, e in
                if let e = e {
                    print(e)
                }
//                print(data)
                if let data = data, let data = try? JSONSerialization.jsonObject(with: data) as? [String: Any]  {
//                    print(data)
                    userAdress = data["ip"] as? String ?? userAdress
//                    country = data["country"] as? String ?? country
//                    cc = data["cc"] as? String ?? cc
                    if let adress = data["ip"] as? String {
                        var bb = objectb.makeRequest(resource: adress)
                        global.session.dataTask(with: bb) { data, urlr, e in
                            if let e = e {
                                print(e)
                            }
//                        print(data)
                            
                            if let data = data, let data = try? JSONSerialization.jsonObject(with: data) as? [String: Any]  {
//                                print(data)
                                cc = data["country"] as? String ?? cc
                                    var bbb = objectc.makeRequest(resource: "alpha/\(cc)")
                                    global.session.dataTask(with: bbb) { data, urlr, e in
                                        if let e = e {
                                            print(e)
                                        }
//                                    print(data)
                                        if let data = data {
//                                            print(data)
//                                            print(String(data:data,encoding: .utf8))
                                            if let oldStri = String(data:data,encoding: .utf8) {
                                                //                                                print(oldStri)
                                                let can = JSONSerialization.isValidJSONObject(data)
                                                let newStri = ("\(can ? "":"{ \"\":")\(oldStri)\(can ? "":"}")")
                                                //                                                print("\(can) : \n \(newStri)")
                                                //                                                print(newStri)
                                                if let data = newStri.data(using: .utf8) {
                                                    print("worded")
                                                    if let data = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                                                        print("jsonified")
                                                        let data = (data.keys == (["":""] as [String:Any]).keys ? data[""] ?? "ERROR" : data as Any)
//                                                        print(data)
                                                        if let data = data as? [[String : Any]] {
                                                            print("made into stem parts")
                                                            if let data = data.first {
                                                                if let data = data["name"] as? [String:Any] {
                                                                    if let data = data["common"] {
                                                                        country = data as? String ?? country
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }.resume()
                            }
                        }.resume()
                    }
                }
            }.resume()
        }
    }
    struct codecountry:api {
        var token: String = ""
        
        var url : String = "https://restcountries.com:443"
        var apiModifier:String = "v3.1"
        init(){}
    }
    struct ipcode:api {
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
    }//https://restcountries.com/v3.1/alpha/US

}

#Preview {
    WhereAmI()
}
