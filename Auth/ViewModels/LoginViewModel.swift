import Foundation
import RealmSwift

final class LoginViewModel {
    
    enum ViewState {
        case error(String)
        case success(String)
    }
    
    private let realm = try? Realm()
    var customerList: Results<Customer>?
    
    var loginListener: ((ViewState) -> Void)?
    
    lazy var numberCheck = false
    lazy var passCheck = false
    
    init() {
        fetchCustomerList() 
    }
    
    func fetchCustomerList() {
        self.customerList = realm?.objects(Customer.self)
    
    }

    func performLogin(phoneNumber: String, password: String) {
        
        guard let customers = customerList else {
            numberCheck = false
            return
        }
        for customer in customers {
            if phoneNumber == customer.phoneNumber {
                numberCheck = true
                if password == customer.customerPassword {
                    passCheck = true
                } else {
                    passCheck = false
                }
                return
            }
        }
        numberCheck = false
    }
}
