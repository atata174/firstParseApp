//
//  MainViewController.swift
//  firstParseApp
//
//  Created by PenguinRaja on 02.03.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var quantityRecipeTF: UITextField!
    @IBOutlet var randomButton: UIButton!
    
    @IBOutlet var ingredientTF: UITextField!
    
    private let apiKey = "apiKey=9639391a2eab40f3b485bfe0c1196c51"
    
    var recipe: Recipe?
    var ingredient: Ingredient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDoneButton(to: quantityRecipeTF)
        addDoneButton(to: ingredientTF)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showKeyboard(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showKeyboard(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
    }
    

    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let randomVC = segue.destination as? RandomViewController else { return }
        randomVC.recipe = recipe
    }
    
    @IBAction func randomButtonAction() {
        
        fetchRecipe(from: "https://api.spoonacular.com/recipes/random?\(apiKey)")
        
        performSegue(withIdentifier: "randomRecipeSegue", sender: nil)
        
    }
    
    @IBAction func ingredientButtonAction() {
        guard let ingredientText = ingredientTF.text else { return }
        if ingredientText != "" && ingredientText.count > 2 {
            
            performSegue(withIdentifier: "ingredientSegue", sender: nil)
        } else {
            errorAlert()
        }
    }
    
    

    private func getRandomRecipe(count: String) {}
    
    private func searchIngridient() {}
    
    private func fetchRecipe(from url: String?) {
        NetworkManager.shared.fetchRecipe(from: url) { recipe in
            self.recipe = recipe
        }
    }
}

// MARK: - Methods for working with the keyboard

extension MainViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
        view.frame.origin.y = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == ingredientTF {
            ingredientButtonAction()
        }
        return true
    }
    
    private func addDoneButton(to textField: UITextField) {
        
        let keyboardToolbar = UIToolbar()
        textField.inputAccessoryView = keyboardToolbar
        keyboardToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            title:"Done",
            style: .done,
            target: self,
            action: #selector(didTapDone)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
        view.frame.origin.y = 0
    }
    
    // hardcoding... sorry
    
    @objc func showKeyboard (notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any],
            let keyboardInfo = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else { return}
        if notification.name != UIResponder.keyboardWillHideNotification {
            view.frame.origin.y = -(keyboardInfo.height / 4)
        }
    }
}

// MARK: - Alert Controllers

extension MainViewController {
    private func successAlert() {
        let alert = UIAlertController(title: "Success",
                                      message: "Success",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func errorAlert() {
        let alert = UIAlertController(title: "Error",
                                      message: "Error",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
