import Foundation
import Alamofire

class MailServiceFacade {
    static var serviceUrl: String?
    
    static func sendEmail(to: String, subject: String, html: String, completion: @escaping (Error?) -> Void) {
        
        let body: [String: Any] = [
            "to": to,
            "subject": subject,
            "html": html,
        ]
        
        guard let serviceUrl = Self.serviceUrl else {
            completion(CustomError.unexpected)
            return
        }
        
        AF.request(serviceUrl, method: .post, parameters: body, encoding: JSONEncoding.default).responseJSON { res in
            print(res)
            completion(nil)
        }
    }
}
