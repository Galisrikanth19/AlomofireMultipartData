//
//  NetworkLayer.swift
//  AlomofireMultipartData
//
//  Created by ELORCE INDUSTRIES PRIVATE LIMITED on 02/12/21.
//

import Foundation
import Alamofire

enum RequestType: String {
    case get
    case post
    case put
}

enum NetworkError: Error {
    case noInternet
    case apiFailure
    case invalidResponse
    case decodingError
}


class NetworkLayer {
    
    func getApiData<T: Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(_ result: T?, _ error: Error?) -> Void) {
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = RequestType.get.rawValue
        addHeaders(urlRequest: &urlRequest)
        requestServer(WithRequest: urlRequest, ForResultType: resultType, completionHandler: completionHandler)
    }
    
    func postApiData<T: Decodable>(requestUrl: URL, resultType: T.Type, requestBody: Data, completionHandler:@escaping(_ result: T?, _ error: Error?) -> Void) {
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = RequestType.post.rawValue
        urlRequest.httpBody = requestBody
        addHeaders(urlRequest: &urlRequest)
        requestServer(WithRequest: urlRequest, ForResultType: resultType, completionHandler: completionHandler)
    }
    
    func putApiData<T: Decodable>(requestUrl: URL, resultType: T.Type, requestBody: Data?, completionHandler:@escaping(_ result: T?, _ error: Error?) -> Void) {
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = RequestType.put.rawValue
        urlRequest.httpBody = requestBody
        addHeaders(urlRequest: &urlRequest)
        requestServer(WithRequest: urlRequest, ForResultType: resultType, completionHandler: completionHandler)
    }
    
    private func requestServer<T: Decodable>(WithRequest urlRequest: URLRequest, ForResultType resultType: T.Type, completionHandler:@escaping(_ result: T?, _ error: Error?)-> Void) {
        print(urlRequest.url!)
        URLSession.shared.dataTask(with: urlRequest) { (responseData, httpUrlResponse, error) in
            DispatchQueue.main.async {
                if let httpResponse = httpUrlResponse as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    if(error == nil && responseData != nil) {
                        responseData?.printFormatedJson()
                        //self.validateResponse(dataIs: responseData!, resultType: T.self)
                        do {
                            let result = try JSONDecoder().decode(T.self, from: responseData!)
                            completionHandler(result, nil)
                        }
                        catch let error {
                            completionHandler(nil, error)
                        }
                    } else {
                        completionHandler(nil, error)
                    }
                } else {
                    completionHandler(nil, NetworkError.noInternet)
                }
            }
        }.resume()
    }
    
    private func addHeaders(urlRequest: inout URLRequest) {
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.addValue((Constants.getAccessToken() ?? ""), forHTTPHeaderField: "accesstoken")
    }
    
    private func validateResponse<T: Decodable>(dataIs: Data, resultType: T.Type) {
        do {
            let decoder = JSONDecoder()
            let messages = try decoder.decode(resultType.self, from: dataIs)
            print(messages as Any)
        } catch DecodingError.dataCorrupted(let context) {
            print(context)
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch DecodingError.valueNotFound(let value, let context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch DecodingError.typeMismatch(let type, let context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
    }
    
    // MARK: Alomofire
    func postMultipartApiData<T: Decodable>(WithUrlString urlStr: String, WithParams params:[String:Any]? = nil, WithImageModelArr imgMArr: [ImageModel?]?, resultType: T.Type, completionHandler:@escaping(_ result: T?, _ error: Error?) -> Void) {
        let boundary = "Boundary-\(UUID().uuidString)"
        var httpHeaders = HTTPHeaders.init()
        let httpHeaderContentType = HTTPHeader.init(name: "Content-Type", value: "multipart/form-data; boundary=\(boundary)")
        let httpHeaderAccesstoken = HTTPHeader.init(name: "accesstoken", value: (Constants.getAccessToken() ?? ""))
        httpHeaders.add(httpHeaderContentType)
        httpHeaders.add(httpHeaderAccesstoken)
        
        AF.upload(multipartFormData: { multipartFormData in
            if let _imgMArr = imgMArr {
                for imgM in _imgMArr {
                    if let _imgM = imgM {
                        if let imageData = _imgM.img.jpegData(compressionQuality: 0.75) {
                            multipartFormData.append(imageData, withName: _imgM.imgName, fileName: "\(_imgM.imgName).png", mimeType: "image/png")
                        }
                    }
                }
            }

            if let _params = params {
                for (key, value) in _params {
                    multipartFormData.append(Data("\(value)".utf8), withName: key)
                }
            }
        }, to: URL(string: urlStr)!, method: .post, headers: httpHeaders).responseDecodable(of: T.self) { (response) in
            switch(response.result) {
            case .success:
                completionHandler(response.value, nil)
                break
            case .failure(let error):
                completionHandler(nil, error)
                break
            }
        }
    }
    
    public func cancelAllTasks(requestType: RequestCancelType = .None) {
        guard requestType != .None else {
            return
        }
        let sessionManager = Alamofire.Session.default
        sessionManager.session.getTasksWithCompletionHandler { (dataTasks, uploadTasks, downloadTasks) in
            if requestType == .All || requestType == .DataTask {
                dataTasks.forEach{$0.cancel()}
            }
            if requestType == .All || requestType == .UploadTask {
                uploadTasks.forEach{$0.cancel()}
            }
            if requestType == .All || requestType == .DownloadTask {
                downloadTasks.forEach{$0.cancel()}
            }
        }
    }
}
enum RequestCancelType {
    case All
    case DataTask
    case UploadTask
    case DownloadTask
    case None
}

extension Data {
    
    func printFormatedJson() {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            
            print(String(decoding: jsonData, as: UTF8.self))
            
        } else {
            assertionFailure("Malformed JSON")
        }
    }
    
}
