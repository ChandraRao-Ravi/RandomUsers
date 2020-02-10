//
//  APIManager.swift
//  InfiniteSol
//
//  Created by Chandra Rao on 09/02/20.
//  Copyright © 2020 Chandra Rao. All rights reserved.
//

import Foundation

protocol UsersProtocol {
    func didReceiveUsersResponse(withData usersData: UserList?, withError error: Error?)
}

class APIManager: NSObject {

    var userDelegate: UsersProtocol?

    static let sharedInstance: APIManager = {
        let instance = APIManager()
        // setup code
        return instance
    }()
    
    // MARK: - Initialization Method
    
    override init() {
        super.init()
    }
    
    func conformToUsersProtocol(withDelegate delegateReceived: UsersProtocol?) {
        if let delegate = delegateReceived {
            self.userDelegate = delegate
        }
    }
    
    func callGetUsersApi(withCount count: String = "0") {
        APIHelper.sharedInstance.makeGetApiCallWithMethod(withMethod: Constants.NumberOfRecords + count, successHandler: { (data, error) in
            guard let responseData = data else {
                print(error?.localizedDescription ?? "Error Occured")
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(UserList.self, from: responseData)
                if let delegate = self.userDelegate {
                    delegate.didReceiveUsersResponse(withData: responseModel, withError: nil)
                } else {
                    fatalError("Conform to Protocol UsersProtocol")
                }
            } catch {
                if let delegate = self.userDelegate {
                    delegate.didReceiveUsersResponse(withData: nil, withError: error)
                } else {
                    fatalError("Conform to Protocol UsersProtocol")
                }
                print("Parse Failed With Error \(error.localizedDescription)")
            }

        }) { (strMessage, error) in
            
        }
    }
}

