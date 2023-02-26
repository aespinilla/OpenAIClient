//
//  URLSessionEventSourceDelegate.swift
//  
//
//  Created by Alberto Espinilla Garrido on 25/2/23.
//

import Foundation

class URLSessionEventSourceDelegate: NSObject, URLSessionDataDelegate {
    var didReceive: ((Data) -> Void)?
    var didOpen: (() -> Void)?
    var didReceiveError: ((Int?, Error?) -> Void)?
    var didReceiveRedirection: ((URLRequest) -> URLRequest?)?
    
    open func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        didReceive?(data)
    }
    
    open func urlSession(_ session: URLSession,
                         dataTask: URLSessionDataTask,
                         didReceive response: URLResponse,
                         completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
        completionHandler(URLSession.ResponseDisposition.allow)
        didOpen?()
    }
    
    open func urlSession(_ session: URLSession,
                         task: URLSessionTask,
                         didCompleteWithError error: Error?) {
        guard let responseStatusCode = (task.response as? HTTPURLResponse)?.statusCode else {
            didReceiveError?(nil, error)
            return
        }
        didReceiveError?(responseStatusCode, error)
    }
    
    open func urlSession(_ session: URLSession,
                         task: URLSessionTask,
                         willPerformHTTPRedirection response: HTTPURLResponse,
                         newRequest request: URLRequest,
                         completionHandler: @escaping (URLRequest?) -> Void) {
        let newRequest = didReceiveRedirection?(request)
        completionHandler(newRequest)
    }
}
