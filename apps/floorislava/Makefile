PROJECT := floorislava

SOURCE := $(PROJECT).star
IMAGE := $(PROJECT).webp

DEVICE_ID := cunningly-immediate-justified-kinglet-da9

.PHONY: $(PROJECT).webp push


floorislava.webp: $(SOURCE)
	pixlet render $<
	
push: $(IMAGE)
	pixlet push $(DEVICE_ID) $<