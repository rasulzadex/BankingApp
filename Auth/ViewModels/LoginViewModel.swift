import Foundation
import RealmSwift

final class LoginViewModel {
    
    private let realm = try? Realm()
    var customerList: Results<Customer>?
    lazy var numberCheck = ""
    lazy var passCheck = ""
    
    init() {
        fetchCustomerList() 
    }
    
    func fetchCustomerList() {
        self.customerList = realm?.objects(Customer.self)
    }
    
    func performLogin(phoneNumber: String, password: String) {
        guard let customers = customerList else {
            numberCheck = "Failed to fetch customers."
            return
        }

        for customer in customers {
            if phoneNumber == customer.phoneNumber {
                numberCheck = "Phone number found"
                if password == customer.customerPassword {
                    passCheck = "Password is correct"
                } else {
                    passCheck = "Password is incorrect"
                }
                return
            }
        }

        numberCheck = "This phone number is not registered"
    }
}
