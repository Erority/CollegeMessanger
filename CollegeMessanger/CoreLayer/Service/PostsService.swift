//
//  PostsService.swift
//  CollegeMessanger
//
//  Created by Студент on 14.12.2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore


protocol PostService {
    func getPost(_ clouser: @escaping (_ allPosts: [PostModel]?, _ error: Error?) -> ())
    func addPost(post: PostModel, _ clouser: @escaping (_ success: Bool, _ error: Error?) -> ())
}


class PostServiceImpl: PostService {
    
    private let collection = Firestore.firestore().collection(FirebaseCollection.posts.rawValue)
    
    @Inject var sesionUserDefualts: FirebaseAuthService!
    
    func getPost(_ clouser: @escaping (_ allPosts: [PostModel]?, _ error: Error?) -> ()) {
        collection.getDocuments { snapshot, error in

            if let error = error {
                print("Error getting documents: \(error)")
                clouser(nil, error)
            } else {
                var allPosts: [PostModel] = []

                for document in snapshot!.documents {
                    allPosts.append(PostModel(postAuthorName: document.data()["post_author_name"] as? String ?? "",
                                              postAuthorUId: document.data()["post_author_uid"] as? String ?? "",
                                              postFiles: document.data()["post_files"] as? [String],
                                              postPictures: document.data()["post_pictures"] as? [String],
                                              postText: document.data()["post_text"] as? String ?? "",
                                              postTimestamp: document.data()["post_timestamp"] as? Timestamp,
                                              postTitle: document.data()["post_title"] as? String ?? "")
                    )
                }
                clouser(allPosts, nil)
            }
        }
    }
    
    
    func addPost(post: PostModel, _ clouser: @escaping (_ success: Bool, _ error: Error?) -> ()) {
        collection.addDocument(data: [
            "post_author_name": post.postAuthorName,
            "post_author_uid": post.postAuthorUId,
            "post_files": post.postFiles ?? [],
            "post_pictures": post.postPictures ?? [],
            "post_text": post.postText,
            "post_timestamp": post.postTimestamp!,
            "post_title": post.postTitle])
        { err in
            if let err = err {
                print("Error adding document: \(err)")
                clouser(false, err)
            } else {
                clouser(true, err)
            }
        }
    }
}
