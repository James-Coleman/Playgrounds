import UIKit

var str = "Hello, playground"

let result: Result<String, Swift.Error> = .success("Hello")

try? result.get()

let rawString = #"this is a raw string and you \() can \" do """ whatever you like inside it\"#

let multiLineRawString = #"""
fvdfnvfnvdfv ### \()
"""#


