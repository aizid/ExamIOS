import Foundation
import SwiftKeychainWrapper

class GlobalFunc {
    
    // REGULAR EXPRESSION
    static func MATCH(value: String, pattern: String) -> Bool{
        let range = value.range(of: pattern, options: .regularExpression)
        if range == nil {
            return false
        } else {
            return true
        }
    }
    
    // GLOBAL FUNCTION
    static func GET_KEYCHAIN_WRAPPER_STRING(key: String) -> String{
        let retriveData: String? = KeychainWrapper.standard.string(forKey: key)
        return retriveData ?? ""
    }
    
    static func GET_KEYCHAIN_WRAPPER_INT(key: String) -> Int{
        let retriveData: Int? = KeychainWrapper.standard.integer(forKey: key)
        return retriveData ?? 0
    }
    
    static func GET_KEYCHAIN_WRAPPER_BOOLEAN(key: String) -> Bool{
        let retriveData: Bool? = KeychainWrapper.standard.bool(forKey: key)
        return retriveData ?? false
    }
    
    static func SET_KEYCHAIN_WRAPPER(key: String, value: String) {
        KeychainWrapper.standard.set(value, forKey: key)
    }
    
    static func SET_KEYCHAIN_WRAPPER_INT(key: String, value: Int) {
        KeychainWrapper.standard.set(value, forKey: key)
    }
    
    static func REMOVE_KEYCHAIN_WRAPPER(key: String){
        KeychainWrapper.standard.removeObject(forKey: key)
    }
    
    static func DISPLAY_ALERT_MESSAGE(userMessage: String, viewController: UIViewController){
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        myAlert.addAction(okAction)
        viewController.present(myAlert, animated: true, completion: nil)
    }
    
    static func DISPLAY_ALERT_MESSAGE_CUSTOM(titleMessage: String ,userMessage: String, viewController: UIViewController){
        let myAlert = UIAlertController(title: titleMessage, message: userMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        myAlert.addAction(okAction)
        viewController.present(myAlert, animated: true, completion: nil)
    }
    
    static func SIMPLE_DATE_FORMAT_CONVERT_ONE_ENCODE(date: String?)-> String {
        if date != nil {
            let dateString = date

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateFromString = dateFormatter.date(from: dateString!)

            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "dd MMMM yyyy"

            let stringFromDate = dateFormatter2.string(from: dateFromString!)
            
            return stringFromDate
        }
        return "-";
    }
   
     static func SIMPLE_DATE_FORMAT_CONVERT_TWO_ENCODE(date: String?)-> String {
            if date != nil {
                let dateString = date

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                let dateFromString = dateFormatter.date(from: dateString!)

                let dateFormatter2 = DateFormatter()
                dateFormatter2.dateFormat = "dd MMMM yyyy"

                let stringFromDate = dateFormatter2.string(from: dateFromString!)
                
                return stringFromDate
            }
            return "-";
        }
    
    
    static func CHECK_STRING_EMPTY_NULL(value:String?) -> Bool{
        if value!.isEmpty || value == nil {
            return false
        } else {
            return true
        }
    }
    
    static func CHECK_STRING_EMPTY_NULL(value:String?) -> String{
        return value ?? ""
    }
    
    static func CHECK_STRING_EMPTY_NULL_RETURN_DASH(value:String?) -> String{
        return value ?? "-"
    }
    
    static func CHECK_INT_EMPTY_NULL(value:Int?) -> Int{
        return value ?? 0
    }
    
    static func IS_VALID_EMAIL(email: String)-> Bool {
        var validate: Bool
        let emailPattern: String = "[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+"
        let emailPattern2: String = "[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+\\.+[a-z]+"
        let emailPattern3: String = "[A-Z0-9a-z._%+-]+@[a-z-*[@#$%^_.*&+=]]+\\.+[a-z]+\\.+[a-z]+"
        
        if self.MATCH(value: email, pattern: emailPattern) {
            validate = true;
        } else if self.MATCH(value: email, pattern: emailPattern2) {
            validate = true;
        } else if self.MATCH(value: email, pattern: emailPattern3) {
            validate = true;
        } else {
            validate = false;
        }
        return validate;
    }
    
    static func IS_VALIDATION_PASSWORD(password: String)-> Bool{
        var validatee: Bool
        let passwordPattern: String = "(?=.*[A-Z])" + "(?=.*[`~!@#$%^&*()_+={}|/?,.<>:;])" + "(?=\\S+$)" + ".{6,}" + "$"
        
        if self.MATCH(value: password, pattern: passwordPattern){
            validatee = true
        } else{
            validatee = false
        }
        return validatee
    }
    
    static func DELETE_ALL_PREFERENCE() {
        REMOVE_KEYCHAIN_WRAPPER(key: Constant.KEY_PREFF_TOKEN)
        REMOVE_KEYCHAIN_WRAPPER(key: Constant.KEY_PREFF_ID_PESERTA)
        REMOVE_KEYCHAIN_WRAPPER(key: Constant.KEY_PREFF_ID_VISITOR)
        REMOVE_KEYCHAIN_WRAPPER(key: Constant.KEY_PREFF_IMG_CODE_PROFILE)
    }
    
    static func INIT_DESCRIPTION_RESPONSE(description: String)-> String {
        var result = "";
        switch (description) {
        case "EMAIL_NOT_EXISTED":
            result = "Email yang anda masukkan salah";
            break;
        case "EMAIL_EXISTED":
            result = "Email telah digunakan";
            break;
        case "OLD_PASSWORD_NOT_MATCHED":
            result = "Password lama yang anda masukkan salah";
            break;
        case "PASSWORD_CHANGED":
            result = "Password berhasil diubah";
            break;
        case "WRONG_PASSWORD":
            result = "Password yang anda masukkan salah";
            break;
        case "EMAIL_NOT_FOUND":
            result = "Email belum terdaftar";
            break;
        case "EMAIL_UNREGISTERED":
            result = "Email belum terdaftar";
            break;
        case "EMAIL_CHANGED":
            result = "Email berhasil diubah";
            break;
        case "SERVER ERROR":
            result = "Server Error";
            break;
        case "PHONE NUMBER ALREADY ACTIVE":
            result = "Nomer Handphone telah terdaftar";
            break;
        case "NIK ALREADY ACTIVE":
            result = "Nik telah terdaftar";
            break;
        case "EMAIL ALREADY ACTIVE":
            result = "Email telah terdaftar";
            break;
        case "NIK NOT FOUND":
            result = "Nik tidak terdaftar";
            break;
        case "OTP_REACH_MAXIMUM_RETRY":
            result = "Request otp telah mencapai batas";
            break;
        case "OTP_EXPIRED":
            result = "Sesi otp telah berakhir";
            break;
        case "WRONG_OTP":
            result = "Otp yang anda masukkan salah";
            break;
        default:
            result = "Undifined Description";
            break;
        }
        return result;
    }
    
    static func INIT_DESCRIPTION_VERIFICATE(status: String, textView: UILabel, imageView: UIImageView) {
        var result: String = ""
        switch (status) {
        case "WAITING":
            result = "Sedang Diproses";
            textView.text = result
            imageView.image = UIImage(named: "ic_acc_wait_verified")
            break;
        case "FAILED":
            result = "Belum Diverifikasi";
            textView.text = result
            imageView.image = UIImage(named: "ic_acc_not_verified")
            break;
        case "VERIFIED":
            result = "Terverifikasi";
            textView.text = result
            imageView.image = UIImage(named: "ic_acc_verified")
            break;
        default:
            result = "Undifined Verification";
            textView.text = result
            imageView.image = UIImage(named: "ic_acc_not_verified")
            break;
        }
    }
    
    static func IMG_URL(imageCode: String, codeService: Int)-> String {
        var result: String = "";
        switch (codeService) {
            case 1:
                result = Constant.BASE_URL + "/api/image-visitor/" + imageCode
                break;
            case 2:
                result = Constant.BASE_URL + imageCode
                break;
            default:
                result = "";
                break;
        }
        return result;
    }
    
    static func INIT_DESCRIPTION_MARRIED(status: Int)-> String {
        var result = "";
        switch (status) {
        case 1:
            result = "Tidak Kawin";
            break;
        case 2:
            result = "Kawin Tanpa Anak";
            break;
        case 3:
            result = "Kawin 1 Anak";
            break;
        case 4:
            result = "Kawin 2 Anak";
            break;
        case 5:
            result = "Kawin 3 Anak";
            break;
        case 6:
            result = "Janda Tanpa Anak";
            break;
        case 7:
            result = "Janda 1 Anak";
            break;
        case 8:
            result = "Janda 2 Anak";
            break;
        case 9:
            result = "Janda 3 Anak";
            break;
        case 10:
            result = "Duda Tanpa Anak";
            break;
        case 11:
            result = "Duda 1 Anak";
            break;
        case 12:
            result = "Duda 2 Anak";
            break;
        case 13:
            result = "Duda 3 Anak";
            break;
        case 14:
            result = "Tanpa Keterangan";
            break;
        default:
            result = "Undifined Tanpa Keterangan";
            break;
        }
        return result;
    }
    
    
    static func  INIT_DESCRIPTION_SEX(status: Int)-> String {
        var result: String = ""
        switch (status) {
        case 1:
            result = "Laki-Laki"
            break
        case 2:
            result = "Perempuan"
            break
        default:
            result = ""
            break
        }
        return result
    }
    
    static func INIT_DESCRIPTION_SEX(status: String)-> String {
        var result: String = ""
        switch (status) {
        case "Laki_laki":
            result = "Laki-Laki"
            break
        case "Perempuan":
            result = "Perempuan"
            break
        default:
            result = ""
            break
        }
        return result
    }
    
    static func INIT_DESCRIPTION_FAMILY_RELATION(status: String)-> String {
        var result: String = ""
        switch (status) {
        case "AK":
            result = "Anak Kandung"
            break
        case "SI":
            result = "Suami/Istri"
            break
        case "AIK":
            result = "Ayah/Ibu Kandung"
            break
        case "KAK":
            result = "Kakak/Adik Kandung"
            break
        case "PK":
            result = "Pihak Ketiga"
            break
        default:
            result = ""
            break
        }
        return result
    }
    
    static func FORMATER_TIME_MILIS_TO_STRING(date: Int64)-> String{
        let value = Double(date)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:m:ss"
        
        return formatter.string(from: Date(timeIntervalSince1970: value))
    }
    
    static func FORMATER_DATE_MILIS_TO_STRING(date: Int64)-> String{
        let value = Double(date)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yy HH:m:ss"
        
        return formatter.string(from: Date(timeIntervalSince1970: value))
    }
    
    static func FORMATER_DATE_ONLY_TO_STRING(date: Int64)-> String{
        let value = Double(date)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yy"
        
        return formatter.string(from: Date(timeIntervalSince1970: value))
    }
    
    static func FORMATER_DATE_ONLY_TO_STRING(date: UInt64)-> String{
        let value = Double(date)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        
        return formatter.string(from: Date(timeIntervalSince1970: value))
    }
    
    static func FORMATER_DATE_WITH_DAYS_TO_STRING(date: UInt64)-> String{
        let value = Double(date)
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM YYYY"
        
        return formatter.string(from: Date(timeIntervalSince1970: value))
    }
    
    
    
    
    
    static func GET_THOUSAND_SEPARATOR_WITHOUT_DECIMAL_POINT(value: Float) -> String{
        return value.formattedWithSeparatorWithoutDcimalPoint
    }
    
    static func GET_THOUSAND_SEPARATOR(value: Float) -> String{
        return value.formattedWithSeparator
    }
    
    static func GET_THOUSAND_SEPARATOR(value: Decimal) -> String{
        return value.formattedWithSeparator
    }
    
    static func GET_THOUSAND_SEPARATOR(value: Int) -> String{
        return value.formattedWithSeparator
    }
    
    //    static func GET_THOUSAN_SEPARATOR(value: Int) -> String{
    //        return value.formattedWithSeparator
    //    }
    
    static func GET_THOUSAN_SEPARATOR(value: Double) -> String{
        return value.formattedWithSeparator
    }
    
}
    
    extension Formatter {
        static let withSeparator: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.groupingSeparator = ","
            formatter.usesGroupingSeparator = true
            formatter.numberStyle = .decimal
            formatter.locale = Locale(identifier: "en_US")
            formatter.maximumFractionDigits = 2
            return formatter
        }()
        
        static let withSeparatorWithoutDecimalPoint: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.groupingSeparator = ","
            formatter.usesGroupingSeparator = true
            formatter.numberStyle = .decimal
            formatter.locale = Locale(identifier: "en_US")
            formatter.maximumFractionDigits = 0
            return formatter
        }()
    }

    extension Numeric {
        var formattedWithSeparator: String {
            return Formatter.withSeparator.string(for: self) ?? ""
        }
        
        var formattedWithSeparatorWithoutDcimalPoint: String {
            return Formatter.withSeparatorWithoutDecimalPoint.string(for: self) ?? ""
        }
    }

    extension Double {
        func truncate(places: Int) -> Double {
            return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
        }
    }


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    func roundedImage() {
         self.layer.cornerRadius = (self.frame.size.width) / 2;
         self.clipsToBounds = true
         self.layer.borderColor = UIColor.white.cgColor
     }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
