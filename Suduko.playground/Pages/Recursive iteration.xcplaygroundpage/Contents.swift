
func optionsFor(array: [Int?]) -> [Int?] {
    if array.contains(nil) {
        var array = array
        guard let firstNil = array.firstIndex(where: { $0 == nil }) else { return array }
        array.remove(at: firstNil)
        
        var i = 1
        while array.contains(i) {
            i += 1
        }
        
        array.insert(i, at: firstNil)
        
        return optionsFor(array: array)
    } else {
        return array
    }
}

optionsFor(array: [])

optionsFor(array: [nil])

optionsFor(array: [1])

optionsFor(array: [nil, nil])

optionsFor(array: [2, nil])

optionsFor(array: [2, nil, nil])

let testArray = [Int?](repeating: nil, count: 9)

optionsFor(array: testArray)

let testArray2: [Int?] = [nil, 9, nil, nil, nil, nil, nil, nil, nil]

optionsFor(array: testArray2)

