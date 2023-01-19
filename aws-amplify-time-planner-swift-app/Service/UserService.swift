//
//  UserService.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 19/1/2023.
//

import Foundation
import Amplify

struct UserService {
    func postTodo() async {
        let message = #"{"message": "my new Todo"}"#
        let request = RESTRequest(path: "/users", body: message.data(using: .utf8))
        do {
            let data = try await Amplify.API.post(request: request)
            let str = String(decoding: data, as: UTF8.self)
            print("Success: \(str)")
        } catch let error as APIError {
            print("Failed due to API error: ", error)
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    func getTodo() async {
        let request = RESTRequest(path: "/users")
        do {
            let data = try await Amplify.API.get(request: request)
            let str = String(decoding: data, as: UTF8.self)
            print("Success: \(str)")
        } catch let error as APIError {
                print("Failed due to API error: ", error)
        } catch {
            print("Unexpected error: \(error)")
        }
    }
}
