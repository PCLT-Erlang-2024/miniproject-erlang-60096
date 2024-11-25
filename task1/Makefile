ERLC = erlc
ERL = erl
MODULES = package_generator conveyor_belt truck factory

NUM_PACKAGES ?= 400
NUM_BELTS ?= 20
NUM_TRUCKS ?= 10
PACKAGE_SIZE ?= 5
TRUCK_CAPACITY ?= 15

REMOVE_CMD = $(if $(findstring Windows,$(OS)),del /Q,rm -f)

all: compile
compile:
	$(ERLC) $(addsuffix .erl, $(MODULES))

run:
	$(ERL) -noshell -eval "factory:start($(NUM_PACKAGES), $(NUM_BELTS), $(NUM_TRUCKS), $(PACKAGE_SIZE), $(TRUCK_CAPACITY))." -s init stop

clean:
	$(REMOVE_CMD) *.beam *.dump
