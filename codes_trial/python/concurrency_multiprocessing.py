import multiprocessing

def function1():
    for i in range(50):
        print("Function 1 is running")

def function2():
    for i in range(5):
        print("Function 2 is running")

if __name__ == "__main__":
    # Create processes
    process1 = multiprocessing.Process(target=function1)
    process2 = multiprocessing.Process(target=function2)

    # Start processes
    process1.start()
    process2.start()

    # Wait for both processes to finish
    process1.join()
    process2.join()

    print("Both functions have finished")
