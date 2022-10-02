
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

//###################################CHALLENGE 1: print in reverse
//              TC: O(N)
//we can use stack to store elements and then pop out
//recursion also uses stack, so we can use recursion instead

func printReverseLL<T>(_ list: LinkedList<T>) {
//    base case: condition for terminating recusrion, if node is nil, it's end of LL
    printReverse(list.head)
}

func printReverse<T>(_ node: Node<T>?) {
//    base case: condition for terminating recusrion, if node is nil, it's end of LL
    guard let node = node else { return }
    printReverse(node.next)
    print(node.data)
}

example(of: "print in reverse") {
    var list = LinkedList<Int>()
    list.push(1)
    list.push(2)
    list.push(3)
    list.push(4)
    list.push(5)
    printReverseLL(list)
}
//######################################################################

//###################################CHALLENGE 2: find the middle
//              TC: O(N)

func getMiddle<T>(_ list: LinkedList<T>) -> Node<T>? {
    var slow = list.head
    var fast = list.head
    while let nextFast = fast?.next {
        fast = nextFast.next
        slow = slow?.next
    }
    return slow
}

example(of: "find the middle") {
    var list = LinkedList<Int>()
    list.append(1)
    list.append(4)
    list.append(51)
    list.append(15)
    list.append(11)
//    list.append(18)
    if let middle = getMiddle(list) {
        print(middle)
    }
    print(list)
    
}
//######################################################################

//###################################CHALLENGE 3: reverse the LL
//              TC: O(N)

extension LinkedList {
    mutating func reverse(){
        tail = head
        var prev = head
        var current = head?.next
        prev?.next = nil
        while(current != nil){
            let next = current?.next
            current?.next = prev
            prev = current
            current = next
        }
        head = prev
    }
}

example(of: "reverse LL") {
    var list = LinkedList<Int>()
    list.append(1)
    list.append(4)
    list.append(51)
    list.append(15)
    list.append(11)
    print(list)
    list.reverse()
    print(list)
}
//######################################################################

//###################################CHALLENGE 4: Merge two lists
//              TC: O(M+N)
// <T: Comparable> is used because we will use binary operator ( <,>) to compare
func mergeSorted<T: Comparable>(_ left: LinkedList<T>, _ right: LinkedList<T>) -> LinkedList<T> {
//    if left LL is empty, return right similarly for right LL
    guard !left.isEmpty else {
        return right
    }
    guard !right.isEmpty else {
        return left
    }
    var newHead: Node<T>?
    var tail: Node<T>?
    
    var currentLeft = left.head
    var currentRight = right.head
    
//    first we will create a single node to define the head of the merged LL, assign head and tail to that node to make append easier (O(1))
    if let leftNode = currentLeft, let rightNode = currentRight {
        if leftNode.data < rightNode.data {
            newHead = leftNode
            currentLeft = leftNode.next
        } else {
            newHead = rightNode
            currentRight = rightNode.next
        }
        tail = newHead
    }
    
//    merging will start now
    while let leftNode = currentLeft, let rightNode = currentRight {
        if leftNode.data < rightNode.data {
            tail?.next = leftNode
            currentLeft = leftNode.next
        } else {
            tail?.next = rightNode
            currentRight = rightNode.next
        }
        tail = tail?.next
    }
    
//    if some nodes are remaining from any of the list
    
    if let leftNode = currentLeft {
        tail?.next = leftNode
    }
    if let rightNode = currentRight {
        tail?.next = rightNode
    }
    
//    instead of using append or insert methods to insert elemenets, we'll simply set refernvce of the head and tail of the list directly
    var list = LinkedList<T>()
    list.head = newHead
    list.tail = {
        while let next = tail?.next {
            tail = next
        }
        return tail
    }()
    
    return list
}

example(of: "merge two lists") {
    var list = LinkedList<Int>()
    list.push(5)
    list.push(3)
    list.push(1)
    var anotherList = LinkedList<Int>()
    anotherList.push(6)
    anotherList.push(4)
    anotherList.push(2)
    let mergedList = mergeSorted(list, anotherList)
    print(mergedList)
}

//######################################################################

//###################################CHALLENGE 5: Trimming List
//              TC: O(N)

extension LinkedList where T: Equatable {
    mutating func removeAll(_ value: T) {
        while let head = self.head, head.data == value {
            self.head = head.next
        }
        var prev = head
        var current = head?.next
        while let currentNode = current {
            if current?.next == nil {
                tail
            }
            guard currentNode.data != value else {
                prev?.next = currentNode.next
                current = prev?.next
                continue
            }
            prev = current
            current = current?.next
        }
        tail = prev
    }
}
example(of: "deleting duplicate nodes") {
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(3)
    list.push(3)
    list.push(1)
    list.removeAll(3)
    print(list)
}
























