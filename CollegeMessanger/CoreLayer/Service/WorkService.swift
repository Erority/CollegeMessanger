//
//  Works.swift
//  CollegeMessanger
//
//  Created by Студент on 21.12.2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

protocol WorkService {
    func getWork(_ clouser: @escaping (_ allWork: [WorkModel]?, _ error: Error?) -> ())
    func addWork(work: WorkModel, _ clouser: @escaping (_ success: Bool, _ error: Error?) -> ())
}


class WorkServiceImpl: WorkService {
    
    private let collection = Firestore.firestore().collection(FirebaseCollection.works.rawValue)
    
    func getWork(_ clouser: @escaping (_ allWork: [WorkModel]?, _ error: Error?) -> ()) {
        collection.getDocuments { snapshot, error in

            if let error = error {
                print("Error getting documents: \(error)")
                clouser(nil, error)
            } else {
                var allWork: [WorkModel] = []

                for document in snapshot!.documents {
                    allWork.append(WorkModel(
                        workAuthorName: document.data()["workAuthorName"] as? String ?? "",
                        workAuthorUID: document.data()["workAuthorUID"] as? String ?? "",
                        workSalary: document.data()["workSalary"] as? String ?? "",
                        workText: document.data()["workText"] as? String ?? "",
                        workTitle: document.data()["workTitle"] as? String ?? "",
                        workType: document.data()["workType"] as? String ?? "")
                    )
                }
                clouser(allWork, nil)
            }
        }
    }
    
    
    func addWork(work: WorkModel, _ clouser: @escaping (_ success: Bool, _ error: Error?) -> ()) {
        collection.addDocument(data: [
            "workAuthorName": work.workAuthorName,
            "workAuthorUID": work.workAuthorUID,
            "workSalary": work.workSalary,
            "workText": work.workText,
            "workTitle": work.workTitle,
            "workType": work.workType])
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

