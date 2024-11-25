[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/MUFtVp-N)

## Author

- João Gonçalo Freitas Pereira 60096

## Build and Run

You can run the program by using the Erlang shell. To do so, you must first compile the program by running the following command in the terminal:

```bash
erl
c(package_generator).
c(conveyor_belt).
c(truck).
c(factory).
```

After compiling the program, you can run the following command to start the simulation:

In case of Task 1:

```bash
factory:start(<NumPackages>, <NumBelts>, <NumTrucks>, <PackageSize>, <TruckCapacity>).
```

Where:

- `<NumPackages>` is the number of packages.
- `<NumBelts>` is the number of conveyor belts.
- `<NumTrucks>` is the number of trucks.
- `<PackageSize>` is the size of the packages.
- `<TruckCapacity>` is the capacity of the trucks.

In case of Task 2 and Task 3:

```bash
factory:start(<NumPackages>, <NumBelts>, <NumTrucks>, <MinPackageSize>, <MaxPackageSize>, <TruckCapacity>).
```

Where:

- `<NumPackages>` is the number of packages.
- `<NumBelts>` is the number of conveyor belts.
- `<NumTrucks>` is the number of trucks.
- `<MinPackageSize>` is the minimum size of the packages.
- `<MaxPackageSize>` is the maximum size of the packages.
- `<TruckCapacity>` is the capacity of the trucks.

Alternatively, you can use the provided Makefile to compile and run the program. To do so, you must run the following command in the terminal:

```bash
make
make run
```

This will compile the program and start the simulation with the default values. If you want to change these values, you can run the following command:

In case of Task 1:

```bash
make run NUM_PACKAGES=<NumPackages> NUM_BELTS=<NumBelts> NUM_TRUCKS=<NumTrucks> PACKAGE_SIZE=<PackageSize> TRUCK_CAPACITY=<TruckCapacity>
```

Where:

- `<NumPackages>` is the number of packages.
- `<NumBelts>` is the number of conveyor belts.
- `<NumTrucks>` is the number of trucks.
- `<PackageSize>` is the size of the packages.
- `<TruckCapacity>` is the capacity of the trucks.

In case of Task 2 and Task 3:

```bash
make run NUM_PACKAGES=<NumPackages> NUM_BELTS=<NumBelts> NUM_TRUCKS=<NumTrucks> MIN_PACKAGE_SIZE=<MinPackageSize> MAX_PACKAGE_SIZE=<MaxPackageSize> TRUCK_CAPACITY=<TruckCapacity>
```

Where:

- `<NumPackages>` is the number of packages.
- `<NumBelts>` is the number of conveyor belts.
- `<NumTrucks>` is the number of trucks.
- `<MinPackageSize>` is the minimum size of the packages.
- `<MaxPackageSize>` is the maximum size of the packages.
- `<TruckCapacity>` is the capacity of the trucks.

When using the Makefile, you only need to specify the values you want to change. The other values will be set to the default values.

After the program has finished running, you can clean the compiled files by running the following command:

```bash
make clean
```

## Build and Run - Examples

Here are some examples of how to run the program using the Erlang shell and the Makefile.

- Erlang shell (Task 1):

```bash
erl
c(package_generator).
c(conveyor_belt).
c(truck).
c(factory).
factory:start(10, 2, 2, 1, 5).
```

- Erlang shell (Task 2 and Task 3):

```bash
erl
c(package_generator).
c(conveyor_belt).
c(truck).
c(factory).
factory:start(10, 2, 2, 1, 5, 5).
```

- Makefile (Task 1):

```bash
make
make run NUM_PACKAGES=10 NUM_BELTS=2 NUM_TRUCKS=2 PACKAGE_SIZE=1 TRUCK_CAPACITY=5
```

- Makefile (Task 2 and Task 3):

```bash
make
make run NUM_PACKAGES=10 NUM_BELTS=2 NUM_TRUCKS=2 MIN_PACKAGE_SIZE=1 MAX_PACKAGE_SIZE=5 TRUCK_CAPACITY=5
```

---

<details>
  <summary>Mini-Project Specification (click to expand)</summary>

# miniproject-erlang

# PCLT - Actor-based Concurrency Module

## Erlang Lab Class #2 - Miniproject

**Note that the mini-project is the same for the three modules (Go, Rust, Erlang).**

**DEADLINE** 27/11/2024 23:59

---

To submit your answers, simply push your files onto the repository. The problem will be graded.

---

## Product Distribution System

The goal of this mini-project is to design and implement a concurrent product distribution system using Erlang’s process-based concurrency model. The system will simulate a factory that handles the shipment of products to clients using a fleet of trucks and multiple conveyor belts.

### General Requirements

- Concurrency: The system must use independent Erlang processes to model conveyor belts and trucks.
- Deadlock-Free: Ensure the absence of deadlocks; all packages must eventually be loaded onto trucks.
- Progress Guarantee: All parts of the system must keep working to process and deliver packages.
- Message Passing: Use Erlang’s message-passing mechanisms for synchronization and coordination.

## Task 1: Core System

#### Goal: Implement the basic system with continuous operation.

- Implement the core system.
- Must account for multiple conveyor belts being “fed” packages continuously and multiple trucks.
- Assume that when a truck is full it can be replaced instantly.
- Conveyor belts can run continuously.
- You need not be very realistic or precise with time, but the relative order of events should be the expected one: a package is loaded onto a conveyor belt before it gets loaded onto a non-full truck.
- The order of events must follow logical steps: a package is created, placed on a conveyor belt, and then loaded onto a non-full truck.

**Note:** Add a small report to the task 1 folder that explains what correctness properties your system has and what achieves them.

## Task 2: Variable Package Sizes

### Goal: Extend the system to support packages of different sizes.

#### Enhancements:

- Each package generated by a conveyor belt has a size (randomly determined or specified).
- Trucks are loaded unevenly based on the size of the packages.

#### Behavior:

- A truck can only load a package if it has enough remaining capacity.
- The system must log package sizes and the updated capacity of trucks after each loading.

**Note:** Add a small report to the task 2 folder that explains what correctness properties your system has and what achieves them.

## Task 3: Non-Instant Truck Replacement

#### Goal: Extend the system to introduce delays for replacing trucks.

#### Enhancements:

- When a truck is full, it takes a non-zero amount of time to be replaced.
- Conveyor belts must pause their operation while waiting for the replacement of a truck at their endpoint.

#### Behavior:

- During truck replacement, a conveyor belt must stop feeding packages to avoid overflows.
- Once the truck is replaced, the conveyor belt resumes its operation.

**Note:** Add a small report to the task 3 folder that explains what correctness properties your system has and what achieves them.

</details>
