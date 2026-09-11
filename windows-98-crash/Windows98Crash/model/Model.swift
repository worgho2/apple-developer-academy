import Foundation
import UIKit

class Model {
    static let shared = Model()
    
    var canRestart = true
    
    var windowsDiscoveredErrors: [WindowsError] = []
    var windowsDiscoveredCritical: [String] = []
    
    let windowsErrors = [
        WindowsError(image: UIImage(named: "error_0")!),
        WindowsError(image: UIImage(named: "error_1")!),
        WindowsError(image: UIImage(named: "error_2")!),
        WindowsError(image: UIImage(named: "error_3")!),
        WindowsError(image: UIImage(named: "error_4")!)
    ]
    
    let windowsTxtCritical = [
        "POST Check Errors",
        "Missing DLL Files",
        "Drive in Not Acessible",
        "Windows Update Error 0x80070057",
        "Virtual Memory Too Low",
        "Device errors",
        "Fatal Exception errors",
        "225 (0xE1)” is “ERROR_VIRUS_INFECTED",
        "Error: 404"
    ]
    
    let btnBackgroundImages = [
        BtnBackgroundImage(normal: UIImage(named: "recyclebin")!, down: UIImage(named: "recyclebin_down")!),
        BtnBackgroundImage(normal: UIImage(named: "mycomputer")!, down: UIImage(named: "mycomputer_down")!),
        BtnBackgroundImage(normal: UIImage(named: "drive(c)")!, down: UIImage(named: "drive(c)_down")!),
        BtnBackgroundImage(normal: UIImage(named: "internetexplorer")!, down: UIImage(named: "internetexplorer_down")!),
        BtnBackgroundImage(normal: UIImage(named: "mydocuments")!, down: UIImage(named: "mydocuments_down")!),
        BtnBackgroundImage(normal: UIImage(named: "start")!, down: UIImage(named: "start_down")!),
        BtnBackgroundImage(normal: UIImage(named: "keyboard")!, down: UIImage(named: "keyboard_down")!),
        BtnBackgroundImage(normal: UIImage(named: "paint")!, down: UIImage(named: "paint_down")!),
        BtnBackgroundImage(normal: UIImage(named: "sound")!, down: UIImage(named: "sound_down")!),
    ]
    
    
    
    private init(){ }
}
