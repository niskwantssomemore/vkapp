//
//  FriendController.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 25/10/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"

class FriendController: UICollectionViewController {
    
    public var friendId: Int = 0
    private let networkService = NetworkService()
    private var photos: [PhotoAdapterStruct] = []
    private let photoAdapterService = PhotoAdapter()
    var notificationToken: NotificationToken?
    private let viewModelFactory = FriendViewModelFactory()
    private var photoModels: [PhotoModel] = []
    private let photoService = PhotoService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        photoAdapterService.getphotos(id: friendId) {  [weak self] photos in
            self?.photos = photos
            self?.photoModels = self?.viewModelFactory.constructViewModels(from: photos) ?? []
            self?.collectionView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }   
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCell", for: indexPath) as? FriendCell else { preconditionFailure("FriendCell cannot be dequeued") }
        cell.configure(with: photoModels[indexPath.row], using: photoService)
        
        return cell
    }
}
extension FriendController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width / 2).rounded(.down)
        return CGSize(width: cellWidth, height: cellWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Big Photo",
            let selectedPhotoIndexPath = collectionView.indexPathsForSelectedItems?.first,
            let bigPhotoVC = segue.destination as? BigPhotoController {
            bigPhotoVC.photos = Array(photos)
            bigPhotoVC.selectedPhotoIndex = selectedPhotoIndexPath.item
            collectionView.deselectItem(at: selectedPhotoIndexPath, animated: true)
        }
    }
}
