PROJECT := floorislava

SOURCE := $(PROJECT).star
IMAGE := $(PROJECT).webp

.PHONY: $(IMAGE) serve


$(IMAGE): $(SOURCE)
	pixlet render $<
	
serve: $(IMAGE)
	pixlet serve $(SOURCE)
	