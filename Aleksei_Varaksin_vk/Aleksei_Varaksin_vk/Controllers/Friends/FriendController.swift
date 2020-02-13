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
    private var photos: Results<Photo>?
    var notificationToken: NotificationToken?
    private let photoService = PhotoService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPhotos()
        tableobesrve()
    }
    func getPhotos () {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        do {
            let realm = try Realm(configuration: config)
            photos = realm.objects(Photo.self).filter("ANY owner.id == %@", friendId)
            networkService.friendphotos(for: friendId) { photos in
                guard let user = realm.object(ofType: User.self, forPrimaryKey: self.friendId) else { return }
                try? realm.write {
                    realm.add(photos, update: .all)
                    user.photos.append(objectsIn: photos)
                }
            }
        } catch {
            show(message: error as! String)
        }
    }
    private func tableobesrve() {
        guard let photo = photos else { return }
        
        notificationToken = photo.observe { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial(_):
                self.collectionView.reloadData()
            case .update(_, let delts, let insrt, let modifs):
                self.collectionView.performBatchUpdates({
                    self.collectionView.insertItems(at: insrt.map({ IndexPath(row: $0, section: 0) }))
                    self.collectionView.deleteItems(at: delts.map({ IndexPath(row: $0, section: 0)}))
                    self.collectionView.reloadItems(at: modifs.map({ IndexPath(row: $0, section: 0) }))
                    self.collectionView.reloadData()
                }, completion: nil)
            case .error(let error):
                self.show(message: error as! String)
            }
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCell", for: indexPath) as? FriendCell else { preconditionFailure("FriendCell cannot be dequeued") }
        if let photos = photos {
            cell.configure(with: photos[indexPath.row], using: photoService)
        }
        
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
extension FriendController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Big Photo",
            let selectedPhotoIndexPath = collectionView.indexPathsForSelectedItems?.first,
            let bigPhotoVC = segue.destination as? BigPhotoController {
            bigPhotoVC.photos = Array(photos!)
            bigPhotoVC.selectedPhotoIndex = selectedPhotoIndexPath.item
            collectionView.deselectItem(at: selectedPhotoIndexPath, animated: true)
        }
    }
}
