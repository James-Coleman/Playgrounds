import Network

let monitor = NWPathMonitor()

monitor.pathUpdateHandler = { path in
    if path.status == .satisfied {
        print("Connected")
    } else {
        print("No connection")
    }
    
    print("Expensive: \(path.isExpensive)")
}

let queue = DispatchQueue(label: "Monitor")
monitor.start(queue: queue)

let wifiMonitor = NWPathMonitor(requiredInterfaceType: .wifi)

wifiMonitor.pathUpdateHandler = { path in
    print("Wifi: \(path.status)")
}

wifiMonitor.start(queue: queue)
