class Queue:
    def __init__(self):
        self.items = []

    def is_empty(self):
        return len(self.items) == 0

    def enqueue(self, item):
        self.items.append(item)  # Add item to the end of the queue

    def dequeue(self):
        if not self.is_empty():
            return self.items.pop(0)  # Remove item from the front of the queue
        return None

    def peek(self):
        if not self.is_empty():
            return self.items[0]  # Get the item at the front without removing it
        return None

    def size(self):
        return len(self.items)  # Return the size of the queue

# Example usage
queue = Queue()
queue.enqueue(1)
queue.enqueue(2)
queue.enqueue(3)

print(queue.dequeue())  # Output: 1 (FIFO order)
print(queue.peek())     # Output: 2
print(queue.size())     # Output: 2
