//
//  URLSessionMock.swift
//  
//
//  Created by Alberto Espinilla Garrido on 29/1/23.
//

import Foundation

class URLSessionMock: URLProtocol {
    
    static var data: Data?
    static var response: URLResponse?
    static var error: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canInit(with task: URLSessionTask) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        if let data = URLSessionMock.data {
            self.client?.urlProtocol(self, didLoad: data)
        }
        
        if let response = URLSessionMock.response {
            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        if let error = URLSessionMock.error {
            self.client?.urlProtocol(self, didFailWithError: error)
        }
        
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
    }
    
    class func reset() {
        data = nil
        response = nil
        error = nil
    }
}
