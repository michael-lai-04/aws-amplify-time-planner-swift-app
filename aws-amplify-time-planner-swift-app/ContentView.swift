//
//  ContentView.swift
//  aws-amplify-time-planner-swift-app
//
//  Created by Michael  Lai on 14/1/2023.
//

import SwiftUI
import Amplify

struct ContentView: View {

    let coreDM: CoreDataManager

    @State private var movieTitle: String = ""
    @State private var movies: [Movie] = [Movie]()
    @State private var needsRefresh: Bool = false
    
    private func populateMovies(){
        movies =  coreDM.getAllMovies()
    }
    
    var body: some View {
        NavigationView{
            VStack{
                TextField("Enter title", text: $movieTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Save"){
                    coreDM.saveMovie(title: movieTitle)
                    populateMovies()
                }
                List{
                    ForEach(movies, id: \.self){
                        movie in
                        NavigationLink(destination: MovieDetailView(movie: movie, coreDM: coreDM, needsRefresh: $needsRefresh), label:{
                            Text(movie.title ?? "")
                        })
                    }.onDelete (perform: { indexSet in
                        indexSet.forEach({
                            index in
                            let movie = movies[index]
                            coreDM.deleteMovie(movie: movie)
                            populateMovies()
                        })
                    })
                }.listStyle(PlainListStyle())
                    .accentColor(needsRefresh ? .white: .black)
                Spacer()
            }.padding()
            .navigationTitle("Movies")
            .onAppear(perform: {
                populateMovies()
            })
        }
    }
    
    func fetchCurrentAuthSession() async {
        do {
            let session = try await Amplify.Auth.fetchAuthSession()
            print("Is user signed in - \(session.isSignedIn)")
        } catch let error as AuthError {
            print("Fetch session failed with error \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    func signUp(username: String, password: String, email: String) async {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        do {
            let signUpResult = try await Amplify.Auth.signUp(
                username: username,
                password: password,
                options: options
            )
            if case let .confirmUser(deliveryDetails, _, userId) = signUpResult.nextStep {
                print("Delivery details \(String(describing: deliveryDetails)) for userId: \(String(describing: userId))")
            } else {
                print("SignUp Complete")
            }
        } catch let error as AuthError {
            print("An error occurred while registering a user \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    func confirmSignUp(for username: String, with confirmationCode: String) async {
        do {
            let confirmSignUpResult = try await Amplify.Auth.confirmSignUp(
                for: username,
                confirmationCode: confirmationCode
            )
            print("Confirm sign up result completed: \(confirmSignUpResult.isSignUpComplete)")
        } catch let error as AuthError {
            print("An error occurred while confirming sign up \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    func signIn(username: String, password: String) async {
        do {
            let signInResult = try await Amplify.Auth.signIn(
                username: username,
                password: password
                )
           print(signInResult)
            if signInResult.isSignedIn {
                print("Sign in succeeded")
            }
        } catch let error as AuthError {
            print("Sign in failed \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM:CoreDataManager())
    }
}
