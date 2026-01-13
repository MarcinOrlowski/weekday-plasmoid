# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Weekday Grid is a KDE Plasma 5 widget (plasmoid) that displays a compact 7-cell horizontal grid showing the current week. It visually distinguishes past days, today, and future days with configurable themes.

## Build and Installation Commands

**Install plasmoid:**
```bash
kpackagetool5 --install src/
```

**Upgrade existing installation:**
```bash
kpackagetool5 --upgrade src/
```

**Reload Plasma shell (to see changes):**
```bash
kquitapp5 plasmashell && kstart5 plasmashell
```

**Package as .plasmoid file:**
```bash
cd src && zip -r ../release/weekday-X.X.X.plasmoid . && cd ..
```

## Architecture

### Directory Structure
- `src/` - Plasmoid source (installed by kpackagetool5)
  - `metadata.desktop` - Plugin metadata (name, version, author, API version)
  - `contents/ui/` - QML UI components
  - `contents/js/` - JavaScript modules
  - `contents/config/` - Configuration schema and UI registration
  - `contents/images/` - Widget icons/logos

### Key Components

**Main entry point:** `src/contents/ui/main.qml`
- Registers compact representation (Week.qml) and full representation (CalendarView.qml)
- Sets up tooltip formatting using DateTimeFormatter.js
- Handles update checking via UpdateChecker.qml

**Week grid rendering:** `src/contents/ui/Week.qml`
- Core widget logic - renders 7-day horizontal grid
- `updateWeekGrid()` / `redrawWidget()` - main rendering functions
- `getUserTheme()` - constructs theme object from plasmoid.configuration
- `getVal()` / `getField()` - resolves theme values with Saturday/Sunday overrides

**Theming system:**
- `src/contents/js/themes.js` - 25+ built-in color themes as JS objects
- `src/contents/ui/Theme.qml` - Theme data model with JSON export
- User themes stored in plasmoid.configuration (pastFg, pastBg, todayFg, etc.)
- Color format: `#AARRGGBB` (alpha + RGB hex)

**Configuration:**
- `src/contents/config/main.xml` - KConfig schema defining all settings
- `src/contents/config/config.qml` - Registers config UI pages
- Config pages: ConfigAppearance, ConfigTheme, ConfigLocale, ConfigCalendar, ConfigTooltip, ConfigThemeExportImport

**Date/time formatting:** `src/contents/js/DateTimeFormatter.js`
- Placeholder system: `{yyyy}`, `{DDD}`, `{dd}`, etc.
- Format directives: `:U` (uppercase), `:L` (lowercase), `:u` (first letter uppercase), `:00` (zero-pad)

### Day indexing convention
- Days are indexed 0-6 where **0 = Sunday, 6 = Saturday**
- Grid positions are relative to configured first day of week

## Plasma 5 API Notes

This widget targets **KDE Plasma 5** using:
- `org.kde.plasma.plasmoid 2.0`
- `org.kde.plasma.core 2.0`
- `org.kde.plasma.components 3.0`
- QtQuick 2.x

Configuration values accessed via `plasmoid.configuration.<entryName>` where entry names are defined in main.xml.
