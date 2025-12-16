//
//  Untitled.swift
//  API playground
//
//  Created by John Sencion on 12/16/25.
//
//import Network
//import NetworkExtension
import Foundation
struct global {
    static let session = URLSession.shared
    static let agent:String = "JHHSJSIM"
}

protocol api {
    /// url in format of ``PROTOCOL://SUB.DOMAIN.TLD``
    var url : String { get }
    /// format of ``API/1`` the part after the base url
    var apiModifier:String { get }
    var endpoint:String { get }
    var token:String { get }
    
    
    
}
extension api {
    var endpoint: String {
        return "\(url)/\(apiModifier + (apiModifier.isEmpty ? "" : "/"))"
    }
//    var apiUrl : String
//    var apiToken = ""
    
    static func pull(req:URLRequest) async -> Optional<(Data, URLResponse)> {
        try? await global.session.data(for: req) //rq.ses.upload(for: req, from: from)
        }
    static func push(req:URLRequest,from:Data) async -> Optional<(Data, URLResponse)> {
//        rq.ses.uploadTask(with: req, from: from)
        try? await global.session.upload(for: req, from: from)
    }
    
    func setHeaders(req: inout URLRequest,acceptType:String="application/json",contentType ct: String = "") {
        if token.count > 0 {
            req.setValue(token, forHTTPHeaderField: "Authorization")
    }
        req.setValue(acceptType, forHTTPHeaderField: "Accept")
        req.setValue(global.agent, forHTTPHeaderField: "User-Agent")
        if ct.count > 0 {
            req.setValue(ct, forHTTPHeaderField: "Content-Type")
        }
        
    }
    
    func makeRequest(resource:String, accept:String = "application/json",method:String = "GET", body: (content:Data?, type:String) = (nil,"")) -> URLRequest {
//        let hasBody = (body.content ?? Data()).count > 0
        var r = URLRequest(url: URL(string: endpoint + resource)!)

        setHeaders(req: &r,acceptType: accept, contentType: body.type)
//        setHeaders(req: &r,)
        r.httpMethod = method
        r.httpBody = body.content
        return r
    }
}

