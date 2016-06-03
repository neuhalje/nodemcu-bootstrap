Example NodeMCU project
=======================

Empty Makefile based project for nodemcu (for ESP8266)
* Example files for WLAN registration
* Unit tests with [lunit](https://www.mroth.net/lunit/)
* [nodemcu-uploader](https://github.com/kmpm/nodemcu-uploader) included via git submodule
* Files in `src/` are compiled on the ESP8266

Usage
-----

`git clone --recursive https://github.com/neuhalje/nodemcu-bootstrap.git` and hack away.

```text
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

License
-------

[WTFPL](http://www.wtfpl.net/)

```text
           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004

    Copyright © 2016 Jens Neuhalfen <jens@neuhalfen.name>

    Everyone is permitted to copy and distribute verbatim or modified
    copies of this license document, and changing it is allowed as long
    as the name is changed.

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

    0. You just DO WHAT THE FUCK YOU WANT TO.
```

