//
//  SecondViewController.swift
//  TransferApp
//
//  Created by Vitaly Glushkov on 06.06.2022.
//

import UIKit

protocol UpdatingDataController: AnyObject {
    var updatingData: String {get set}
}

class SecondViewController: UIViewController, UpdatingDataController {

    @IBOutlet weak var dataTextField: UITextField!
    var updatingData: String = ""
    var handleUpdatedDataDelegate: DataUpdateProtocol?
    var completionHandler: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTextFieldData(withText: updatingData)
    }
    
    private func updateTextFieldData(withText text: String) {
        dataTextField.text = text
    }
    
    @IBAction func saveDataWithProperty(_ sender: UIButton) {
        self.navigationController?.viewControllers.forEach { viewController in
            (viewController as? UpdatableDataController)?.updatedData = dataTextField.text ?? ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toFirstScreen":
            prepareFirstScreen(segue)
        default:
            break
        }
    }
    
    private func prepareFirstScreen(_ segue: UIStoryboardSegue) {
        guard let destinationController = segue.destination as? ViewController else {
            return
        }
        destinationController.updatedData = dataTextField.text ?? ""
    }
    
    @IBAction func saveDataWithDelegate(_ sender: UIButton) {
        let updatedData = dataTextField.text ?? ""
        handleUpdatedDataDelegate?.onDataUpdate(data: updatedData)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveDataWithClosure(_ sender: UIButton) {
        let updatedData = dataTextField.text ?? ""
        completionHandler?(updatedData)
        navigationController?.popViewController(animated: true)
    }
    
}
