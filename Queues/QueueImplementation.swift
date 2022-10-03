//protocol defines the core operations on a queue

//• enqueue: Insert an element at the back of the queue. Returns true if the operation was successful.
//• dequeue: Remove the element at the front of the queue and return it.
//• isEmpty: Check if the queue is empty.
//• peek: Return the element at the front of the queue without removing it.

//Doubly linked list

class Node<T>: CustomStringConvertible{
    
    var data: T
    var prev: Node<T>?
    var next: Node<T>?
    
    init(_ data: T){
        self.data = data
    }
    
    var description: String {
        String(describing: data)
    }
}
class DoublyLinkedList<T> {
    var head: Node<T>?
    var tail: Node<T>?
    public init() { }
    
    var isEmpty: Bool {
        head == nil
    }
    var first: Node<T>? {
        head
    }
    func append(_ value: T) {
        
        let newNode = Node(value)
        //        check if list is empty
        guard let newTail = tail else {
            head = newNode
            tail = newNode
            return
        }
        newNode.prev = tail
        newTail.next = newNode
        tail = newNode
        
        
    }
    
    func remove(_ node: Node<T>) -> T {
        let prev = node.prev
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.prev = prev
        if next == nil{
            tail = prev
        }
        node.prev = nil
        node.next = nil
        
        return node.data
    }
}

extension DoublyLinkedList: CustomStringConvertible {
    
    public var description: String {
        var string = ""
        var current = head
        while let node = current {
            string.append("\(node.data) -> ")
            current = node.next
        }
        return string + "end"
    }
}

class LinkedListIterator<T>: IteratorProtocol {
    
    var current: Node<T>?
    
    init(node: Node<T>?) {
        current = node
    }
    
    func next() -> Node<T>? {
        defer { current = current?.next }
        return current
    }
}

extension DoublyLinkedList: Sequence {
    
    func makeIterator() -> LinkedListIterator<T> {
        LinkedListIterator(node: head)
    }
}
//########################################################################

protocol Queue {
    
    associatedtype T
    mutating func enqueue(_ element: T) -> Bool
    mutating func dequeue() -> T?
    var isEmpty: Bool { get }
    var peek: T? { get }
}

//#################################### ARRAY BASED IMPLEMENTATION

struct QueueArray<T>: Queue {
    //    O(1)
    mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }
    //    O(N)
    mutating func dequeue() -> T? {
        isEmpty ? nil : array.removeFirst()
    }
    //    O(1)
    var isEmpty: Bool {
        array.isEmpty
    }
    //    O(1)
    var peek: T? {
        array.first
    }
    
    var array: [T] = []
    
}
extension QueueArray: CustomStringConvertible {
    var description: String {
        String(describing: array)
    }
}
var queue = QueueArray<String>()
queue.enqueue("Nancy")
queue.enqueue("A")
queue.enqueue("r")
queue
queue.dequeue()
queue
queue.peek

//########################################################################

//#################################### Doubly Linked List BASED IMPLEMENTATION
class QueueLinkedList<T>: Queue {
    var list = DoublyLinkedList<T>()
    
    func enqueue(_ element: T) -> Bool {
        list.append(element)
        return true
    }
    
    func dequeue() -> T? {
        guard !list.isEmpty, let element = list.first else {
            return nil
        }
        return list.remove(element)
    }
    
    var isEmpty: Bool {
        list.isEmpty
    }
    
    var peek: T? {
        list.first?.data
    }
}
extension QueueLinkedList: CustomStringConvertible {
    var description: String {
        String(describing: list)
    }
}
var queue2 = QueueLinkedList<String>()
queue2.enqueue("N")
queue2.enqueue("r")
queue2.enqueue("t")
queue2
queue2.dequeue()
queue2
queue2.peek

//########################################################################

//#################################### 2 STACKS BASED IMPLEMENTATION

//we will have 2 stacks left and right, enqueue in right stack then dequeue from left stack, while doing dequeue, if left stack is empty( nothing to dequeue), pop all elemenets from right to left ( they will be in reverse order), then pop from left( that is dequeue), do all operations as usual. Push all elements to left when left stack is empty.

struct QueueStack<T>: Queue {
    mutating func enqueue(_ element: T) -> Bool {
        rightStack.append(element)
        return true
    }
    
    mutating func dequeue() -> T? {
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        return leftStack.popLast()
    }
    
    var isEmpty: Bool {
        leftStack.isEmpty && rightStack.isEmpty
    }
    
    var peek: T? {
        !leftStack.isEmpty ? leftStack.last : rightStack.first
    }
    
    var leftStack: [T] = []
    var rightStack: [T] = []
}
extension QueueStack: CustomStringConvertible {
    var description: String {
        String(describing: leftStack.reversed() + rightStack)
    }
}

var queue3 = QueueStack<String>()
queue3.enqueue("gt")
queue3.enqueue("yh")
queue3.enqueue("we")
queue3
queue3.dequeue()
queue3
queue3.peek






















