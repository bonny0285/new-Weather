//
//  CollectionExtensions.swift
//  Meteo
//
//  Created by Bonafede Massimiliano on 04/06/21.
//  Copyright © 2021 Massimiliano Bonafede. All rights reserved.
//

import Foundation

extension Collection {
    func chunk(by predicate: @escaping (Iterator.Element, Iterator.Element) -> Bool) -> [SubSequence] {
        var res: [SubSequence] = []
        var i = startIndex
        var j = index(after: i)
        while i != endIndex {
            j = self[j..<endIndex]
                .firstIndex(where: { !predicate(self[i], $0) } ) ?? endIndex
            /*         ^^^^^ error: incorrect argument label in call
                                    (have 'where:', expected 'after:') */
            res.append(self[i..<j])
            i = j
        }
        return res
    }
}
