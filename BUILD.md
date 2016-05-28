Building
=========

Using the Makefile
------------------

```text
# make usage

-------  installing
make upload FILE:=<file>  to upload a specific file (i.e make upload FILE:=init.lua)
make upload_assets        to upload assets
make upload_server        to upload the server code including init.lua
make upload_init          to upload init.lua
make upload_config        to upload config.lua
make upload_all           to upload all
-------  testing
make check                to run all unit tests
-------  debugging
make debug_show_status    to display system information via serial
make reset                to reset the controller
make format               to format the filesystem (remove all files but keep the image)
make ls                   to list all files
```


Dependencies
---------------

### Development Machine
* `make` (probably gnu-make)
* `python` (2.7 should be enough)

### nodemcu

* NodeMCU 1.5.1 or above (others not tested)
* Modules:
** bit
** cjson
** encoder
** file
** gpio
** mdns
** net
** node
** rtctime
** sntp
** struct
** tmr
** uart
** wifi
** ws2812
