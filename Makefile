######################################################################
# User configuration
######################################################################
# Path to nodemcu-uploader (https://github.com/kmpm/nodemcu-uploader)
NODEMCU_UPLOADER_LOCATION=${PWD}/util/nodemcu-uploader/nodemcu-uploader.py

# http://www.mroth.net/lunit/
LUNIT=./dependencies/lunit/lunit

# Serial port
PORT=/dev/cu.SLAB_USBtoUART
#SPEED=9600
SPEED=115200

NODEMCU_UPLOADER=$(NODEMCU_UPLOADER_LOCATION) --baud $(SPEED) --start_baud $(SPEED) --port $(PORT)

######################################################################
# End of user config
######################################################################
ASSET_FILES := $(wildcard assets/*)
TEST_FILES := $(wildcard test/*.lua)
DEBUG__FILES := $(wildcard debug/*.lua)
LUA_FILES := \
   src/sysinfo.lua \
   src/setup.lua \
   src/startup.lua \
   src/application.lua

LUA_TEST_PATH=./dependencies/lunit/?.lua
LUA_PATH=${LUA_TEST_PATH};./src/?.lua


# Print usage
usage:
	@echo "-------  installing"
	@echo "make upload FILE:=<file>  to upload a specific file (i.e make upload FILE:=init.lua)"
	@echo "make upload_assets        to upload assets"
	@echo "make upload_server        to upload the server code including init.lua"
	@echo "make upload_init          to upload init.lua"
	@echo "make upload_config        to upload config.lua"
	@echo "make upload_all           to upload all"
	@echo "-------  testing"
	@echo "make check                to run all unit tests"
	@echo "-------  debugging"
	@echo "make debug_show_status    to display system information via serial"
	@echo "make reset                to reset the controller"
	@echo "make format               to format the filesystem (remove all files but keep the image)"
	@echo "make ls                   to list all files"

check:
	#$(foreach test, $(TEST_FILES), ${LUNIT} --path '${LUA_PATH}'  $(test))
	${LUNIT} --path '${LUA_PATH}'  $(foreach test, $(TEST_FILES),  $(test))

upload:
	@python $(NODEMCU_UPLOADER) upload $(FILE)

# Upload assets only
upload_assets: $(ASSET_FILES)
	@python $(NODEMCU_UPLOADER) upload $(foreach f, $^, $(f))

# Upload debug scripts (not compiled)
upload_debug: $(DEBUG__FILES)
	@python $(NODEMCU_UPLOADER) upload $(foreach f, $^, $(f))

# Upload init.lua only
upload_init:
	@python $(NODEMCU_UPLOADER) upload init.lua manual_start.lua

# Upload config.lua only
upload_config:
	@python $(NODEMCU_UPLOADER) upload config.lua

# Upload lua files
upload_server: upload_init upload_config
	# Rather hackishly upload the files without 'src/' prefix.
	(cd src; python $(NODEMCU_UPLOADER) --baud  $(SPEED) --start_baud  $(SPEED) --port $(PORT) upload --compile $(foreach f, $(LUA_FILES), `basename $(f)`))

# Upload all
upload_all: upload_assets upload_debug upload_server reset

### UTIL

format:
	@python $(NODEMCU_UPLOADER) file format
 
ls:
	@python $(NODEMCU_UPLOADER) file list

reset:
	@python $(NODEMCU_UPLOADER) node restart

terminal:
	@python $(NODEMCU_UPLOADER)  terminal

debug_show_status:
	@python $(NODEMCU_UPLOADER) exec debug/show_status.lua
