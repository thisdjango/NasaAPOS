//
//  ViewController.swift
//  nasay
//
//  Created by thisdjango on 17.04.2021.
//

import UIKit

class ViewController: UIViewController {
    var viewModel = ViewModel()
    var images: [UIImage]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var model: [NasaModel]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = UIColor(red: CGFloat.random(in: 20...200)/255.0, green: CGFloat.random(in: 20...200)/255.0, blue: CGFloat.random(in: 20...200)/255.0, alpha: 1)
        
        viewModel.grabData { [weak self] model in
            self?.model = model
            var tmpImg = [UIImage]()
            model.forEach { item in
                self?.viewModel.loadImage(string: item.url ?? "") { data in
                    guard let image = UIImage(data: data) else { return }
                    tmpImg.append(image)
                    if model.last?.url == item.url { self?.images = tmpImg }
                }
            }
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 250, height: 250)
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        
        collectionView.register(NasaViewCell.self, forCellWithReuseIdentifier: NasaViewCell.cellId)
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        collectionView.pin()
    }
}

// Delegate
extension ViewController: UICollectionViewDelegate {
    
}
// Data Source
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NasaViewCell.cellId, for: indexPath) as? NasaViewCell
        else { return UICollectionViewCell() }
        
        cell.text = model?[indexPath.row].title
        if indexPath.row < (images?.count ?? indexPath.row) {
            cell.image = images?[indexPath.row]
        }
        
        return cell
    }
}
