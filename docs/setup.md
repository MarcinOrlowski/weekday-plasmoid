## Installation ##

Download `weekday.plasmoid` file from
[project Release section](https://github.com/MarcinOrlowski/weekday-plasmoid/releases).
Then you can install it either via Panel's GUI, by clicking "Add widgets", then "Get new widgets..."
on the bottom of newly opened widget chooser, then click "Install from local file..." and eventually
selecting downloaded `weekday.plasmoid` file.

Alternatively you can install it from command line, by using `kpackagetool5` in your terminal:

    kpackagetool5 --install /PATH/TO/DOWNLOADED/weekday.plasmoid 

## Upgrading ##

If you already have `OctoPrint Monitor` installed and just downloaded newer `weekday.plasmoid` file,
use `--upgrade` switch of `kpackagetool5` to upgrade your current installation and keep your settings intact:

    kpackagetool5 --upgrade /PATH/TO/DOWNLOADED/weekday.plasmoid

**NOTE:** Sometimes, due to Plasma internals, newly installed version may not be instantly seen working,
so you may want to convince Plasma by doing manual reload:

    kquitapp5 plasmashell && kstart5 plasmashell
    
**NOTE:** this will **NOT** log you out nor affects any other apps. 

