func simpleCallback(completion: () -> Void) {
    print("Simple callback about to call completion")
    completion()
    print("Simple callback after completion")
}

simpleCallback {
    print("Simple callback in the callback")
}

func callbackWithParameter(completion: (String) -> Void) {
    print("Callback with parameter about to call completion")
    completion("badgers")
    print("Callback with parameter after completion")
}

callbackWithParameter { (returnedString) in
    print("Callback with parameter: \(returnedString)")
}

func successAndFail(shouldSucceed: Bool, onSuccess: () -> Void, onFailure: () -> Void) {
    print("Succeeding or failing")
    if shouldSucceed {
        onSuccess()
    } else {
        onFailure()
    }
}

successAndFail(shouldSucceed: true, onSuccess: {
    print("Success")
}, onFailure: {
    print("Failure")
})

successAndFail(shouldSucceed: false, onSuccess: {
    print("Success")
}, onFailure: {
    print("Failure")
})

func callbackWithReturn(completion: (String) -> String) {
    let test = completion("input")
    print(test)
}

callbackWithReturn { (returnedString) -> String in
//    print(returnedString)
    return returnedString + " output"
}

func callbackWithOnlyReturn(completion: () -> String) {
    let test = completion()
    print(test)
}

callbackWithOnlyReturn { () -> String in
    return "only return"
}

func doubleReturn(completion: (String) -> String) -> String {
    return completion("inside")
}

let test = doubleReturn { (input) -> String in
    return input + " outside"
}

print(test)

func mockRefresh(completion: (String) -> String) -> String {
    return completion("Refreshed")
}

func mockRequest(refresh: Bool, completion: (String) -> String) -> String {
    if refresh {
        return completion("with refresh inside")
    } else {
        return completion("without refresh inside")
    }
}

let mockWithoutRefresh = mockRequest(refresh: false) { (returnedString) -> String in
    return returnedString + " without refresh outside"
}

print(mockWithoutRefresh)

let mockWithRefresh = mockRequest(refresh: true) { (returnedString) -> String in
    return returnedString + " with refresh outside"
}

print(mockWithRefresh)

func mockRefresh2(succeed: Bool, completion: (String?) -> String?) -> String? {
    if succeed {
        return completion(" + refreshed")
    } else {
        return nil
    }
}

func mockRequest2(succeed: Bool, refresh: Bool, refreshSucceeds: Bool, completion: (String?) -> String?) -> String? {
    if refresh {
        return mockRefresh2(succeed: refreshSucceeds, completion: completion)
    } else if succeed {
        return completion("succeeded straight away")
    } else {
        return completion(nil)
    }
}

let succeed = mockRequest2(succeed: true, refresh: false, refreshSucceeds: false) { (returnedString) -> String? in
    if let returnedString = returnedString {
        return "successful " + returnedString
    } else {
        return nil
    }
}

let refreshed = mockRequest2(succeed: true, refresh: true, refreshSucceeds: true) { (returnedString) -> String? in
    if let returnedString = returnedString {
        return "successful " + returnedString
    } else {
        return nil
    }
}

let refreshFails = mockRequest2(succeed: true, refresh: true, refreshSucceeds: false) { (returnedString) -> String? in
    if let returnedString = returnedString {
        return "successful " + returnedString
    } else {
        return nil
    }
}

// Could you map the refresh request to the actual request?
// Value of type 'Cancellable' has no member 'map'

