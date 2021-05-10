import UIKit

class PokeApiViewController: UIViewController {
    
    @IBOutlet weak var pokeTextField: UITextField!
    @IBOutlet weak var pokeListPicker: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var viewPokeModel = ViewModelPokemon()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setUpPicker()
        setUpTextField()
        
        //imageView
        imageView.layer.borderWidth = 8
        imageView.layer.cornerRadius = imageView.frame.size.height/2
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.newred.cgColor
    }
    
    func setUpPicker(){
        pokeListPicker.delegate = self
        pokeListPicker.dataSource = self
        viewPokeModel.getListPokemon()
    }
    
    func bind() {
        viewPokeModel.refreshData = {[weak self] () in
            DispatchQueue.main.async { [self] in
                self?.pokeListPicker.isHidden = true
            }
        }
    }
    
    func setUpTextField() {
        pokeTextField.delegate = self
        pokeTextField.inputView = pokeListPicker
    }

}
extension PokeApiViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewPokeModel.dataArrayPokemonList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewPokeModel.dataArrayPokemonList[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pokeTextField.text = viewPokeModel.dataArrayPokemonList[row].name
        pokeListPicker.isHidden = true
    }
    
}

extension PokeApiViewController: UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        pokeListPicker.isHidden = false
        return false
    }
    
}

extension UIColor {
    
    static let newred = UIColor(red: 227.0/255.0, green: 71.0/255.0, blue: 73.0/255.0, alpha: 1.0)
    
}
