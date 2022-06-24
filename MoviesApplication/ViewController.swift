//
//  ViewController.swift
//  MoviesApplication
//
//  Created by Mehmet Baturay Yasar on 23/06/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var languageTextField: UITextField!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    var picker = UIPickerView()
    var language = [String]()
    var movieResult = [FilmResult]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMoviesCollectionView()
        setupTextField()
        setupPickerView()
        getLanguage()
    }

    func setupPickerView() {
        picker.delegate = self
        picker.dataSource = self
    }
    
    func setupTextField() {
        languageTextField.inputView = picker
    }
    
    func setupMoviesCollectionView() {
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        let uinib = UINib(nibName: "MovieCell", bundle: nil)
        moviesCollectionView.register(uinib, forCellWithReuseIdentifier: "MovieCell")
    }
    
    func getLanguage() {
        NetworkManager.shared.getLanguages { language, status in
            if status {
                self.language = language
                DispatchQueue.main.async {
                    self.picker.reloadAllComponents()
                }
            }else {
                print("")
            }
        }
    }
    
    func getFilmResult(language:String) {
        NetworkManager.shared.getFilmList(language: language) { movieResult, status in
            if status == false {
                print("aaaaa")
            }else {
                if let movieResult = movieResult?.results {
                    self.movieResult = movieResult
                    DispatchQueue.main.async {
                        self.moviesCollectionView.reloadData()
                    }
                }
            }
        }
    }

}

// MARK: -CollectionView-
extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movieResult[indexPath.row]
        cell.imageView.downloaded(from: movie.imageurl?.first ?? "")
        cell.titleLabel.text = movie.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: 115)
    }
    
}

// MARK: -PickerView-
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return language.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return language[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedLanguage = language[row]
        getFilmResult(language: selectedLanguage)
        
    }
    
}
