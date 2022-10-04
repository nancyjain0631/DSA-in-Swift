class BinaryNode<Element> {
  var value: Element
  var leftChild: BinaryNode?
  var rightChild: BinaryNode?
  
  init(value: Element) {
    self.value = value
  }
}
var tree: BinaryNode<Int> = {
  let zero = BinaryNode(value: 0)
  let one = BinaryNode(value: 1)
  let five = BinaryNode(value: 5)
  let seven = BinaryNode(value: 7)
  let eight = BinaryNode(value: 8)
  let nine = BinaryNode(value: 9)
  let ten = BinaryNode(value: 10)
  seven.leftChild = one
  one.leftChild = zero
  one.rightChild = five
  seven.rightChild = nine
  nine.leftChild = eight
  nine.rightChild = ten
  return seven
}()

func height<Element>(of node: BinaryNode<Element>?) -> Int {
  guard let node = node else {
    return -1
  }
  return 1 + max(height(of: tree.leftChild), height(of: tree.rightChild))
}
height(of: tree)
public func example(of description: String, action: () -> Void) {
  print("---Example of \(description)---")
  action()
  print()
}
example(of: "tree") {
  print(tree)
}
example(of: "in order") {
  tree.inOrderTraversal { print($0) }
}
example(of: "pre order") {
  tree.preOrderTraversal { print($0) }
}
example(of: "post order") {
  tree.postOrderTraversal { print($0) }
}
example(of: "height") {
  let height = height(of: tree)
  print(height)
}
example(of: "serialize order") {
  tree.serializeOrder{ print($0)}
}
extension BinaryNode {
  func inOrderTraversal(visit: (Element) -> Void) {
    leftChild?.inOrderTraversal(visit: visit)
    visit(value)
    rightChild?.inOrderTraversal(visit: visit)
  }
}

extension BinaryNode {
  func preOrderTraversal(visit: (Element) -> Void) {
    visit(value)
    leftChild?.preOrderTraversal(visit: visit)
    rightChild?.preOrderTraversal(visit: visit)
  }
}

extension BinaryNode {
  func postOrderTraversal(visit: (Element) -> Void){
    leftChild?.postOrderTraversal(visit: visit)
    rightChild?.postOrderTraversal(visit: visit)
    visit(value)
  }
}

extension BinaryNode {
  func serializeOrder(visit: (Element?) -> Void) {
    visit(value)
    if let leftChild = leftChild {
      leftChild.preOrderTraversal(visit: visit)
    } else {
      visit(nil)
    }
    if let rightChild = rightChild {
      rightChild.preOrderTraversal(visit: visit)
    } else {
      visit(nil)
    }
  }
}

extension BinaryNode: CustomStringConvertible {
  var description: String {
    diagram(for: self)
  }
  func diagram(for node: BinaryNode?,
               _ top: String = "",
               _ root: String = "",
               _ bottom: String = ""
  ) -> String {
    guard let node = node else {
      return root + "nil\n"
    }
    if node.leftChild == nil && node.rightChild == nil {
      return root + "\(node.value)\n"
    }
    return diagram(for: node.rightChild,
                   top + " ", top + "┌──", top + "│ ")
    
    + root + "\(node.value)\n"
    + diagram(for: node.leftChild,
              bottom + "│ ", bottom + "└──", bottom + " ")
  }
}
