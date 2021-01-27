* dev
  * Added placeholders for seconds: `{s}` and `{ss}`.
  * Added locale based date/time placeholders: `{ldl}`, `{lds}`, `{ltl}`, `{lts}`, `{ldtl}` and `{ldts}`.
  * `{k}` now returns hour in 12hrs-based clock.
  * Theme editor's Bold/Italic checkboxes are now replaced with labeled buttons (@Zren [#55]).
  * Fixed `{k}` and `{kk}` to return `12` instead of incorrect `0` for 12hrs clock.
  * Added `.pragma library` to all stateless JS files (@Zren).

* v1.5.0 (2021-01-19)
  * Added huge set of predefined color schemes.
  * Clicking on widget opens CalendarView popup.
  * Added support for user configurable week days' labels
  * Added (optional) visual indicator of last day of the month.
  * Added support for `{wy}` (week of the year) placeholder.
  * Added support for `00` placeholder formatting directive.
  * Added support for theme export/import (as JSON).
  * Theme switcher no longer changes theme instantly bug follows Apply/Cancel pattern.
  * Separated user theme configuration pane from Appearance config.
  * Replaced use of Timer with hour aligned data source to make widget less resource hungry.
  * Theme editor features "Fake calendar" mode now, to make theme testing a breeze.
  * Fixed widget's tooltip sub-text not working properly.

* v1.4.0 (2021-01-10)
  * Added bunch of predefined color schemes.
  * Added separate (optional) appearance of future Saturday and Sunday.
  * Added separate (optional) appearance of past Saturday and Sunday.
  * Added separate (optional) appearance of today Saturday and Sunday.
  * Added separated general widget background color.
  * Added option to export current custom theme as JSON string.
  * Added option to clone built-in theme into custom colors for easy tweaking.
  * Added option to swap colors in custom theme editor.
  * Added fully configurable tooltip texts with placeholders support.
  * Fixed Tooltip not using custom locale.

* v1.3.0 (2020-12-18)
  * Added update availability checker.
  * Corrected layout items.

* v1.2.0 (2020-12-17)
  * Added widget tooltip with current date.
  * Added option to override used locale.
  * Added customizable week start day.
  * Appearance can now be configured.
  * Separate look config for past, current and future days.

* v1.1.0 (2020-12-16)
  * General code cleamup.
  * Week layout not uses GridLayout for better positioning.

* v1.0.0 (2020-12-15)
  * Initial public release.
