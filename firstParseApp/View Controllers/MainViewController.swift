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
    
    var recipes: [RecipeRandom] = []
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
        randomVC.recipes = recipes
        randomVC.countRandomRecipes = recipes.count
    }
    
    @IBAction func randomButtonAction() {
        guard let count = quantityRecipeTF.text else { return }
        if let doubleCount = Double(count){
            if doubleCount > 0 && doubleCount < 11 {
                getRandomRecipe(count: count)
                performSegue(withIdentifier: "randomRecipeSegue", sender: nil)
            }
        } else {
            errorAlert()
        }
        
    }
    
    @IBAction func ingredientButtonAction() {
        guard let ingredientText = ingredientTF.text else { return }
        if ingredientText != "" && ingredientText.count > 2 {
            
            performSegue(withIdentifier: "ingredientSegue", sender: nil)
        } else {
            errorAlert()
        }
        

    }
    private func getRandomRecipe(count: String) {
        guard let url = URL(string: "https://api.spoonacular.com/recipes/random?number=\(count)&\(apiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            if let _ = response {
                print("response")
            }
            guard let data = data else { return}
            
            do {
                let recipeRandomFetch = try JSONDecoder().decode(RecipeRandom.self, from: data)

                self.recipes.append(recipeRandomFetch)
                
                DispatchQueue.main.async {
                    self.successAlert()
                }
            } catch let error {
                print(error)
                DispatchQueue.main.async {
                    self.errorAlert()
                }
            }
        }.resume()
    }
    
    private func searchIngridient() {
        print("ingredient")
    }
    

}

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
