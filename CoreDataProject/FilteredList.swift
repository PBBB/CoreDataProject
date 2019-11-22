//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by PBB on 2019/11/21.
//  Copyright © 2019 PBB. All rights reserved.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }

    init(filterKey: String, predicateType: PredicateOperator, filterValue: String, sortDescriptors: [NSSortDescriptor], @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(predicateType.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
}

enum PredicateOperator: String {
    case beginsWith = "BEGINSWITH"
    case contains = "CONTAINS"
}

struct FilteredList_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
