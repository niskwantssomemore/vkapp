//
//  FriendController.swift
//  Aleksei_Varaksin_vk
//
//  Created by Aleksei Niskarav on 25/10/2019.
//  Copyright © 2019 Aleksei Niskarav. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FriendController: UICollectionViewController {
    
    public var friendId = Int()
    private let networkService = NetworkService()
    public var friendImages = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.friendphotos(for: friendId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(photo):
                self.friendImages = photo
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case let .failure(error):
                print(error)
            }
        }
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCell", for: indexPath) as? FriendCell else { preconditionFailure("FriendCell cannot be dequeued") }
        let photo = friendImages[indexPath.row]
        cell.configure(with: photo)
        
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
}

//extension FriendController {
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "Show Big Photo",
//            let selectedPhotoIndexPath = collectionView.indexPathsForSelectedItems?.first,
//            let bigPhotoVC = segue.destination as? BigPhotoController {
//            bigPhotoVC.photos = friendImages
//            bigPhotoVC.selectedPhotoIndex = selectedPhotoIndexPath.item
//            collectionView.deselectItem(at: selectedPhotoIndexPath, animated: true)
//        }
//    }
//}
