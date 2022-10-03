//Queue using 2 stacks
public struct Queue<T> {
  
  private var leftStack: [T] = []
  private var rightStack: [T] = []
  
  public init() {}
  
  public var isEmpty: Bool {
    leftStack.isEmpty && rightStack.isEmpty
  }
  
  public var peek: T? {
    !leftStack.isEmpty ? leftStack.last : rightStack.first
  }
  
  @discardableResult public mutating func enqueue(_ element: T) -> Bool {
    rightStack.append(element)
    return true
  }
  
  public mutating func dequeue() -> T? {
    if leftStack.isEmpty {
      leftStack = rightStack.reversed()
      rightStack.removeAll()
    }
    return leftStack.popLast()
  }
}
//###################################################### Tree starts
class TreeNode<T> {
    var value: T
    var children: [TreeNode] = []
    
    init(_ value: T) {
        self.value = value
    }
//    add child node to a node
    func add(_ child: TreeNode) {
        children.append(child)
    }
}
func makeBeveragesTree() -> TreeNode<String> {
    let tree = TreeNode("Beverages")
    let hot = TreeNode("Hot")
    let cold = TreeNode("Cold")
    let tea = TreeNode("Tea")
    let coffee = TreeNode("coffee")
    let chocolate = TreeNode("chocolate")
    let blackTea = TreeNode("blackTea")
    let greenTea = TreeNode("greenTea")
    let chaiTea = TreeNode("chai")
    let soda = TreeNode("soda")
    let milk = TreeNode("milk")
    let gingerAle = TreeNode("ginger ale")
    let bitterLemon = TreeNode("bitter lemon")
    tree.add(hot)
    tree.add(cold)
    hot.add(tea)
    hot.add(coffee)
    hot.add(chocolate)
    cold.add(soda)
    cold.add(milk)
    tea.add(blackTea)
    tea.add(greenTea)
    tea.add(chaiTea)
    soda.add(gingerAle)
    soda.add(bitterLemon)
    return tree
}
func example(of description: String, action: () -> Void) {
  print("---Example of: \(description)---")
  action()
  print()
}

example(of: "creating a tree") {
    let beverages = TreeNode("Beverages")
    let hot = TreeNode("Hot")
    let cold = TreeNode("Cold")
    beverages.add(hot)
    beverages.add(cold)
}
example(of: "depth-first traversal") {
    let tree = makeBeveragesTree()
    tree.forEachDepthFirst {
        print($0.value)
    }
}
example(of: "level-order traversal") {
    let tree = makeBeveragesTree()
    tree.forEachLevelOrder {
        print($0.value)
        
    }
}
example(of: "Searching for a node") {
    let tree = makeBeveragesTree()
    if let searchResult1 = tree.search("coffeecold") {
        print("Found node: \(searchResult1.value)")
    } else {
        print("node not found")
    }
}


extension TreeNode {
//    recursion
    func forEachDepthFirst(visit: (TreeNode) -> Void) {
        visit(self)
        children.forEach {
            $0.forEachDepthFirst(visit: visit)
        }
    }
    
}
extension TreeNode {
    func forEachLevelOrder(visit: (TreeNode) -> Void){
        visit(self)
        var queue = Queue<TreeNode>()
        children.forEach { queue.enqueue($0) }
        while let node = queue.dequeue() {
            visit(node)
            node.children.forEach { queue.enqueue($0) }
        }
    }
}

//  Searching
extension TreeNode where T: Equatable {
    func search(_ value: T) -> TreeNode? {
        var result: TreeNode?
        forEachLevelOrder { node in
            if node.value == value {
                result = node
            }
        }
        return result
    }
}

