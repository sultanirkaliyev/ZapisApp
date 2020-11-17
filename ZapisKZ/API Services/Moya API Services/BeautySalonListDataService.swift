//
//  BeautySalonListDataService.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation
import Moya
import PromiseKit

class BeautySalonListDataService {
    
    //MARK: - Request Typealias
    typealias RequestBeautySalonListResult = Result<ServerResponseBeautySalonsListData, NetworkRequestFailureReason>
    typealias RequestBeautySalonInformationResult = Result<ServerResponseBeautyProviderDetailData, NetworkRequestFailureReason>
    
    //MARK: - Token
    
    static let tokenClosure: () -> String = {
        return AuthTokenService.shared.getToken()
    }
    
    static let authPlugin = AccessTokenPlugin(tokenClosure: tokenClosure)
    
    //MARK: - Network Error Handler
    
    fileprivate let networkErrorHandler = NetworkErrorHandler()
    
    //MARK: - Provider
    
    fileprivate let provider = MoyaProvider<BeautySalonListService>(endpointClosure: { (target: BeautySalonListService) -> Endpoint in
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        switch target {
        default:
            let httpHeaderFields = ["Accept": "application/json"]
            return defaultEndpoint.adding(newHTTPHeaderFields: httpHeaderFields)
        }
    }, manager: DefaultAlamofireSessionManager.shared, plugins: [authPlugin, NetworkLoggerPlugin(verbose: false)])
}

//MARK: - Network Requests

extension BeautySalonListDataService {
    
    func getMainPageInformation() -> Promise<RequestBeautySalonListResult> {
        
        return Promise<RequestBeautySalonListResult> { seal in
            
            provider.request(.getMainPageInformation) { (response) in
                
                switch response {
                case .success(let result):
                    
                    do {
                        let serverJSON = try JSONDecoder().decode(ServerResponseMainPage.self, from: result.data)
                        
                        if let beautySalonsData = serverJSON.data {
                            seal.fulfill(.success(payload: beautySalonsData))
                        } else {
                            seal.reject(NetworkRequestFailureReason.parseError)
                        }
                    } catch let error {
                        print(error)
                        seal.reject(NetworkRequestFailureReason.parseError)
                    }
                    
                case .failure(let error):
                    
                    switch error {
                    case .statusCode(let statusCode):
                        seal.reject(self.networkErrorHandler.handleNetworkErrorByStatusCode(statusCode))
                    case .underlying(let error, let response):
                        seal.reject(self.networkErrorHandler.handleNetworkError(error, response))
                    default:
                        seal.reject(NetworkRequestFailureReason.failed)
                    }
                }
            }
        }
    }
    
    func getBeautyProviderInformation(beautyProviderID: Int) -> Promise<RequestBeautySalonInformationResult> {
        
        return Promise<RequestBeautySalonInformationResult> { seal in
            
            provider.request(.getBeautyProviderInformation(beautyProviderID: beautyProviderID)) { (response) in
                
                switch response {
                case .success(let result):
                    
                    do {
                        let serverJSON = try JSONDecoder().decode(ServerResponseBeautyProviderDetail.self, from: result.data)
                        
                        if let beautyProviderData = serverJSON.data {
                            seal.fulfill(.success(payload: beautyProviderData))
                        } else {
                            seal.reject(NetworkRequestFailureReason.parseError)
                        }
                    } catch let error {
                        print(error)
                        seal.reject(NetworkRequestFailureReason.parseError)
                    }
                    
                case .failure(let error):
                    
                    switch error {
                    case .statusCode(let statusCode):
                        seal.reject(self.networkErrorHandler.handleNetworkErrorByStatusCode(statusCode))
                    case .underlying(let error, let response):
                        seal.reject(self.networkErrorHandler.handleNetworkError(error, response))
                    default:
                        seal.reject(NetworkRequestFailureReason.failed)
                    }
                }
            }
        }
    }
}
