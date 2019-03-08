//
//  ResponseObjectSerializable.swift
//  PuenteVehicularGobernadores
//
//  Created by Erika Esther Torres Verdin on 11/10/17.
//  Copyright © 2017 Erika Esther Torres Verdin. All rights reserved.
//

import Foundation
import Alamofire

@objc public protocol ResponseObjectSerializable {
    init?(response: HTTPURLResponse, representation: AnyObject)
}

/*extension Alamofire.Request {
 public func responseObject<T: ResponseObjectSerializable>(completionHandler: (NSURLRequest, HTTPURLResponse?, T?, NSError?) -> Void) -> Self {
 let serializer: Serializer = { (request, response, data) in
 let JSONSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
 let (JSON: AnyObject?, serializationError) = JSONSerializer(request, response, data)
 if response != nil && JSON != nil {
 return (T(response: response!, representation: JSON!), nil)
 } else {
 return (nil, serializationError)
 }
 }
 
 return response(serializer: serializer, completionHandler: { (request, response, object, error) in
 completionHandler(request, response, object as? T, error)
 })
 }
 }*/

