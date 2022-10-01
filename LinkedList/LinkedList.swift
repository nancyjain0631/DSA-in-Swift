
class Node<T> {
    var data: T
    var next: Node?
    init(data: T, next: Node? = nil){
        self.data = data
        self.next = next
    }
}
struct LinkedList<T> {
    var head: Node<T>?
    var tail: Node<T>?
    init(){ }
    var isEmpty: Bool {
        head == nil
    }
    
//    PUSH - adding a node at the beginning of the LL
    mutating func push(_ value: T) {
        let newNode = Node(data: value, next: head)
        head = newNode
        if(tail == nil) {
            tail = head
        }
    }
//    APPEND - adding a node at the END of the LL
    mutating func append(_ value: T){
        if isEmpty {
            self.push(value)
            return
        }
        var newNode = Node(data: value)
        tail?.next = newNode
        tail = newNode
    }
//    INSERT AT - adding a node after a specified position
//    INSERT AT has 2 methods-> node and insert, becaue first it will find the node after which we want to insert a new node
    mutating func node(at index: Int) -> Node<T>? {
        var currentIndex = 0
        var currentNode = head
        while(currentNode != nil && currentIndex < index){
            currentNode = currentNode?.next
            currentIndex += 1
        }
        return currentNode
        
    }
//    @discardableResult lets callers ignore the return value of this method without the compiler jumping up and down warning you about it.
    @discardableResult
    mutating func insert(_ value: T, after node: Node<T>) -> Node<T> {
//        check if node is last node, i.e, we have to insert a node at the last that would be append
        guard tail !== node else {
            append(value)
            return tail!
        }
        let newNode = Node(data: value, next: node.next)
        node.next = newNode
        return node.next!
    }
//    POP - removes elemenets from the top
    @discardableResult
    mutating func pop() -> T? {
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.data
    }
    
//    REMOVE LAST- removes from the last
    mutating func removeLast() -> T? {
        guard let head = head else {
            return nil
        }
//        single node
        guard head.next != nil else{
            return pop()
        }
        var prev = head
        var current = head
        while let next = current.next {
            prev = current
            current = next
        }
        prev.next = nil
        tail = prev
        return current.data
    }
    
    //    REMOVE at - removes at specified position
    
    mutating func remove(after node: Node<T>) -> T? {
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.data
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        guard let next = next else {
            return "\(data)"
        }
        return "\(data) -> " + String(describing: next) + " "
    }
}

extension LinkedList: CustomStringConvertible {
    var description: String {
        guard let head = head else { return "Empty List" }
        return String(describing: head)
    }
}

func example(of description: String, action: () -> Void) {
  print("---Example of \(description)---")
  action()
  print()
}

//example(of: "creating and linking nodes") {
//    let node1 = Node(data: 1)
//    let node2 = Node(data: 2)
//    let node3 = Node(data: 3)
//    node1.next = node2
//    node2.next = node3
//    print(node1)
//}

example(of: "push") {
    var list = LinkedList<Int>()
    list.push(3)
    list.push(4)
    list.push(5)
    list.push(6)
    list.push(7)
    print(list)
}
example(of: "append") {
    var list = LinkedList<Int>()
    list.append(3)
    list.append(4)
    list.append(9)
    list.append(5)
    list.append(2)

    print(list)
}

example(of: "inserting at particular index") {
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)
    var middlenode = list.node(at: 1)!
//    for _ in 1...3 {
//        middlenode = list.insert(6, after: middlenode)
//    }
    list.insert(6, after: middlenode)
    print(list)
}

example(of: "pop") {
    var list = LinkedList<Int>()
    list.push(1)
    list.push(2)
    list.push(3)
    list.push(4)
    list.push(5)
    let poppedValue = list.pop()!
    print(poppedValue)
    print(list)
}

example(of: "removeLast") {
    var list = LinkedList<Int>()
    list.push(1)
    list.push(2)
    list.push(3)
    list.push(4)
    list.push(5)
    list.removeLast()
    print(list)
}
example(of: "remove at") {
    var list = LinkedList<Int>()
    list.push(1)
    list.push(2)
    list.push(3)
    list.push(4)
    list.push(5)
//    index start from top
    let nodeToDelete = list.node(at: 0 )
    list.remove(after: nodeToDelete!)
    print(list)
}
























