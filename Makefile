.PHONY: build

OUTPUT_NAME=runtimecalc
BUILD_FOLDER=build
SRC_FOLDER=src
OBJ_FILE=$(BUILD_FOLDER)/$(OUTPUT_NAME).o
OUTPUT_FILE=$(BUILD_FOLDER)/$(OUTPUT_NAME)

IMAGE_TAG=eebor/$(OUTPUT_NAME)

all32: build32 run32
 
build32:
	@mkdir -p $(BUILD_FOLDER)
	@cd src; nasm -f elf32 ../$(SRC_FOLDER)/main86.asm -o ../$(OBJ_FILE)
	@ld -m elf_i386 $(OBJ_FILE) -o $(OUTPUT_FILE) --strip-all

build64:
	@mkdir -p $(BUILD_FOLDER)
	@cd src; nasm -f elf64 ../$(SRC_FOLDER)/main64.asm -o $(OBJ_FILE)
	@ld $(OBJ_FILE) -o $(OUTPUT_FILE)

run32:
	@$(OUTPUT_FILE)

all32docker: build32docker rundocker

build32docker:
	@docker build -t $(IMAGE_TAG) --build-arg BUILD_SRC=$(OUTPUT_FILE) .

rundocker:	
	@docker container run -it --rm $(IMAGE_TAG):latest

clean: 
	@rm -r $(BUILD_FOLDER)
