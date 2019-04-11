import UIKit
import SceneKit
import PlaygroundSupport

extension Float {
    var radToDeg: Float {
        return (self / (2 * .pi)) * 360
    }
}

let string = "test"

let view = SCNView(frame: CGRect(x: 0, y: 0, width: 600, height: 600))
let scene = SCNScene()
view.scene = scene

let cameraNode = SCNNode()
cameraNode.camera = SCNCamera()
cameraNode.position = SCNVector3(0, 5, 0)
cameraNode.eulerAngles = SCNVector3(Double.pi / -2, 0, 0)
scene.rootNode.addChildNode(cameraNode)

/*
let sphere1 = SCNSphere(radius: 1)
sphere1.firstMaterial?.diffuse.contents = UIColor.red
let sphere1Node = SCNNode(geometry: sphere1)
sphere1Node.position
scene.rootNode.addChildNode(sphere1Node)

let sphere2 = SCNSphere(radius: 1)
sphere2.firstMaterial?.diffuse.contents = UIColor.blue
let sphere2Node = SCNNode(geometry: sphere2)
sphere2Node.position = SCNVector3(2.5, 0, -2.5)
scene.rootNode.addChildNode(sphere2Node)
*/

let cubeRed = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
cubeRed.firstMaterial?.diffuse.contents = UIColor.red
cubeRed.firstMaterial?.specular.contents = UIColor.white
let cubeRedNode = SCNNode(geometry: cubeRed)
cubeRedNode.position
cubeRedNode.eulerAngles = SCNVector3(0, Double.pi / 4, 0)
scene.rootNode.addChildNode(cubeRedNode)

let cubeBlue = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
cubeBlue.firstMaterial?.diffuse.contents = UIColor.blue
cubeBlue.firstMaterial?.specular.contents = UIColor.white
let cubeBlueNode = SCNNode(geometry: cubeBlue)
cubeBlueNode.position = SCNVector3(-2, 0, 2)
scene.rootNode.addChildNode(cubeBlueNode)

let light = SCNLight()
light.type = .omni
let lightNode = SCNNode()
lightNode.light = light
lightNode.position = SCNVector3(0, 5, 0)
scene.rootNode.addChildNode(lightNode)

let ambientLight = SCNLight()
ambientLight.type = .ambient
ambientLight.intensity = 200
let ambientLightNode = SCNNode()
ambientLightNode.light = ambientLight
scene.rootNode.addChildNode(ambientLightNode)

PlaygroundPage.current.liveView = view

let dx = cubeRedNode.worldPosition.x - cubeBlueNode.worldPosition.x
let dz = cubeRedNode.worldPosition.z - cubeBlueNode.worldPosition.z

let radAngle = atan2(dx, dz)

radAngle.radToDeg

let adjustedAngle: Float = {
    if radAngle <= 0 {
        return abs(radAngle)
    } else {
        return (2 * .pi) - radAngle
    }
}()

adjustedAngle.radToDeg

let offsetAngle = radAngle - cubeRedNode.eulerAngles.y
offsetAngle.radToDeg

let adjustedOffsetAngle: Float = {
    if offsetAngle <= 0 {
        return abs(offsetAngle)
    } else {
        return (2 * .pi) - offsetAngle
    }
}()
adjustedOffsetAngle.radToDeg
