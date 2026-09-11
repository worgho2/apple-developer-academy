import Foundation
import FirebaseAuth
import FirebaseDatabase

enum UserCategory: String {
    case vendor = "vendor"
    case mechanic = "mechanic"
}

class AuthFacade {
    
    private static let database: DatabaseReference = Database.database().reference()
    
    static func verifyAlreadyAuthenticatedUser(completion: @escaping (UserCategory?) -> Void) {
        guard
            Auth.auth().currentUser != nil,
            let userCategory = UserDefaults.standard.string(forKey: "lastSignedUserCategory")
        else {
            completion(nil)
            return
        }
        
        if userCategory == UserCategory.vendor.rawValue {
            completion(.vendor)
        } else if userCategory == UserCategory.mechanic.rawValue {
            completion(.mechanic)
        } else {
            completion(nil)
        }
    }
    
    static func authenticateUser(email: String, password: String, completion: @escaping (UserCategory?, Error?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (data, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, CustomError.one)
                return
            }
            
            let uid = data.user.uid
                        
            AuthFacade.database.child(UserCategory.vendor.rawValue).child(uid).observeSingleEvent(of: .value) { vendorSnapshot in
                if
                    vendorSnapshot.exists(),
                    let data = vendorSnapshot.value as? NSDictionary,
                    let storedEmail = data["email"] as? String,
                    storedEmail == email
                {
                    completion(.vendor, nil)
                    UserDefaults.standard.set(UserCategory.vendor.rawValue, forKey: "lastSignedUserCategory")
                    return
                }
                
                AuthFacade.database.child(UserCategory.mechanic.rawValue).child(uid).observeSingleEvent(of: .value) { mechanicSnapshot in
                    if
                        mechanicSnapshot.exists(),
                        let data = mechanicSnapshot.value as? NSDictionary,
                        let storedEmail = data["email"] as? String,
                        storedEmail == email
                    {
                        completion(.mechanic, nil)
                        UserDefaults.standard.set(UserCategory.mechanic.rawValue, forKey: "lastSignedUserCategory")
                        return
                    }
                    
                    AuthFacade.deauthenticateUser { _ in
                        completion(nil, CustomError.two)
                        return
                    }
                }
            }
        })
    }
    
    static func deauthenticateUser(completion: @escaping (Error?) -> Void ) {
        do {
            try Auth.auth().signOut()
            Model.instance.reset()
            completion(nil)
            return
        } catch {
            completion(error)
            return
        }
    }
    
    static func registerUser(category: UserCategory, email: String, password: String, name: String, address: String, phone: String, completion: @escaping (_ id: String?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (data, error) in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, CustomError.unexpected)
                return
            }
            
            let uid = data.user.uid
            
            let value: [String : Any] = [
                "name": name,
                "email": email,
                "address": address,
                "phone": phone
            ]
            
            AuthFacade.database.child(category.rawValue).child(uid).setValue(value) { error, reference in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                completion(uid, nil)
            }
        })
    }
}
