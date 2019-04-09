import Foundation

func isPrime(n: Int, from primes: [Int]) -> Bool {
    for prime in primes {
        if Double(prime) > sqrt(Double(n)) {
            return true
        } else
            if n % prime == 0 {
                return false
        }
    }
    
    return true
}

func primeMaker(n: Int) -> (nthPrime: Int, entireArray: [Int])? {
    if n <= 0 {
        return nil
    }
    
    var arrayOfPrimes = [2]
    
    var countOfPrimesArray: Int {
        return arrayOfPrimes.count
    }
    
    var lastPrime: Int {
        return arrayOfPrimes[countOfPrimesArray - 1]
    }
    
    var numberToTest = lastPrime + 1
    
    while countOfPrimesArray < n {
        
        if isPrime(n: numberToTest, from: arrayOfPrimes) {
            arrayOfPrimes += [numberToTest]
        }
        
        if numberToTest == 2 {
            numberToTest = 3
        } else {
            numberToTest += 2
        }
    }
    
    return (lastPrime, arrayOfPrimes)
}

primeMaker(n: 200)
