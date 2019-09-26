import Foundation
import UIKit

class AlertService {
    func getAlertVC(viewController: TransferColorProtocol) -> ColorPickerVC {
       let storyboard = UIStoryboard(name: "ColorPickAlertStoryboard", bundle: .main)
        let alertVC = storyboard.instantiateViewController(withIdentifier: "ColorPickAlertVC") as! ColorPickerVC
        alertVC.delegate = viewController
        return alertVC
    }
}
