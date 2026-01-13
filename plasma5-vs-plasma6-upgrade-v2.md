# Porting KDE plasmoids from Plasma 5 to Plasma 6

KDE Plasma 6, released February 28, 2024, requires **complete reworking of plasmoids** due to fundamental changes in Qt, KDE Frameworks, and the Plasma API itself. The migration demands updating metadata formats, replacing root QML elements, rewriting imports, and converting to declarative action APIs—there is no backward compatibility. Developers must specifically add `"X-Plasma-API-Minimum-Version": "6.0"` to metadata or widgets simply won't appear.

The good news: most changes follow predictable patterns, and once you understand the mapping between old and new APIs, porting becomes largely mechanical. This guide provides the complete technical reference needed to migrate existing Plasma 5 plasmoids to Plasma 6.

## Architectural foundations have shifted significantly

Plasma 6 builds on **Qt 6.6 minimum** and **KDE Frameworks 6**, representing the first major platform change since Plasma 5's 2014 release. The Qt 5 to Qt 6 transition brought sweeping changes: `QVector` merged into `QList`, `QRegExp` was replaced by `QRegularExpression`, and the rendering pipeline now uses Qt's new RHI (Rendering Hardware Interface) abstraction supporting Vulkan, Metal, and Direct3D alongside OpenGL.

For QML specifically, **unversioned imports became standard**—writing `import QtQuick 2.15` in Qt 6 can cause bugs, while `import QtQuick` works correctly. The `variant` property type now behaves identically to `var`, implicit string-to-type conversions were removed (requiring explicit `Qt.color("red")` calls), and URL resolution changed to stay relative until needed.

**KDE Frameworks 6** reorganized several components. The plasma-framework repository moved to `libplasma`. KCM code previously split between KDeclarative and KConfigWidgets consolidated into KCMUtils. The `KDE4Support` compatibility layer was removed entirely. Library naming switched from `KF5::*` to `KF6::*` prefixes.

Plasma 6 defaults to **Wayland** with X11 available as a separate session package. X11-specific features like global shortcuts from X11 apps, input emulation via xdotool, and legacy clipboard managers may require portal-based alternatives. Developers can detect the session type using `QX11Info::isPlatformX11()` for code that needs platform-specific behavior.

## The PlasmoidItem root element is now mandatory

The most visible breaking change: **the root QML element must be `PlasmoidItem`** (or `ContainmentItem` for containments). Generic `Item` roots no longer work. This architectural shift separates the QML interface (`PlasmoidItem`) from the underlying C++ `Applet` instance more cleanly.

Properties that previously used the `Plasmoid` attached property now become direct properties on `PlasmoidItem`:

```qml
// Plasma 5 - attached property syntax
Item {
    Plasmoid.toolTipMainText: "My Widget"
    Plasmoid.fullRepresentation: Item { ... }
    Plasmoid.compactRepresentation: Item { ... }
}

// Plasma 6 - direct properties on PlasmoidItem
PlasmoidItem {
    toolTipMainText: "My Widget"
    fullRepresentation: Item { ... }
    compactRepresentation: Item { ... }
}
```

Properties that moved to `PlasmoidItem` include `switchWidth`, `switchHeight`, `compactRepresentation`, `fullRepresentation`, `preferredRepresentation`, `expanded`, `activationTogglesExpanded`, `hideOnWindowDeactivate`, and all tooltip properties. The `Plasmoid` attached property still provides access to `icon`, `title`, `configuration`, `formFactor`, and `location`.

The `Plasmoid.nativeInterface` accessor was removed—C++ properties from plugin backends are now accessed directly via `Plasmoid.myProperty`.

**Important:** When accessing `expanded` from child components (like a separate compactRepresentation file), you can no longer use `plasmoid.expanded`. Instead, use a signal pattern:

```qml
// In child component (e.g., CompactView.qml)
ColumnLayout {
    signal toggleExpanded()

    MouseArea {
        onClicked: toggleExpanded()
    }
}

// In main.qml
PlasmoidItem {
    id: root
    compactRepresentation: CompactView {
        onToggleExpanded: root.expanded = !root.expanded
    }
}
```

## Import statements require systematic replacement

Every import needs updating. **Remove all version numbers** from imports—Qt 6's module system handles versioning differently, and specifying versions can cause resolution failures.

### Core Qt and Plasma imports

| Plasma 5 Import | Plasma 6 Import |
|-----------------|-----------------|
| `import QtQuick 2.15` | `import QtQuick` |
| `import QtQuick.Layouts 1.15` | `import QtQuick.Layouts` |
| `import QtQuick.Controls 2.15` | `import QtQuick.Controls` |
| `import org.kde.plasma.core 2.0 as PlasmaCore` | `import org.kde.plasma.core as PlasmaCore` |
| `import org.kde.plasma.plasmoid 2.0` | `import org.kde.plasma.plasmoid` |
| `import org.kde.plasma.components 2.0` | **Removed entirely** |
| `import org.kde.plasma.components 3.0 as PC3` | `import org.kde.plasma.components as PC3` |
| `import org.kde.plasma.extras 2.0` | `import org.kde.plasma.extras` |
| `import QtGraphicalEffects 1.0` | `import Qt5Compat.GraphicalEffects` |
| `import org.kde.kirigami 2.20 as Kirigami` | `import org.kde.kirigami as Kirigami` |
| `import org.kde.kquickcontrols 2.0` | `import org.kde.kquickcontrols` |
| `import org.kde.plasma.configuration 2.0` | `import org.kde.plasma.configuration` |

### Module path changes (commonly missed!)

These module paths changed entirely—not just version removal:

| Plasma 5 Import | Plasma 6 Import |
|-----------------|-----------------|
| `import org.kde.plasma.calendar 2.0` | `import org.kde.plasma.workspace.calendar` |
| `import Qt.labs.settings 1.0` | `import QtCore` |

**PlasmaComponents 2 was completely removed**—all widgets must port to PlasmaComponents 3, which wraps Qt Quick Controls 2. This affects `ListItem` (now `ItemDelegate` or `PlasmaExtras.ListItem`), `ContextMenu` (now `PlasmaExtras.Menu`), and numerous other components.

### Legacy QtQuick.Controls 1.x

If your code uses `QtQuick.Controls 1.x` (the old desktop-style controls), you must migrate to `QtQuick.Controls` (v2) or use PlasmaComponents equivalents:

```qml
// Plasma 5 - mixed controls (BAD)
import QtQuick.Controls 1.0  // Legacy!
CheckBox { ... }

// Plasma 6 - use QtQuick.Controls 2 or PlasmaComponents
import QtQuick.Controls as QtControls
QtControls.CheckBox { ... }
// or
import org.kde.plasma.components as PlasmaComponents
PlasmaComponents.CheckBox { ... }
```

### Theme and units migrated to Kirigami

The `PlasmaCore.Theme` and `PlasmaCore.Units` namespaces migrated to Kirigami:

| Plasma 5 | Plasma 6 |
|----------|----------|
| `PlasmaCore.Theme.textColor` | `Kirigami.Theme.textColor` |
| `PlasmaCore.Theme.backgroundColor` | `Kirigami.Theme.backgroundColor` |
| `PlasmaCore.Units.smallSpacing` | `Kirigami.Units.smallSpacing` |
| `PlasmaCore.Units.largeSpacing` | `Kirigami.Units.largeSpacing` |
| `PlasmaCore.Units.gridUnit` | `Kirigami.Units.gridUnit` |
| `PlasmaCore.Units.devicePixelRatio` | `1` (literal value, DPI handled automatically) |
| `PlasmaCore.IconItem` | `Kirigami.Icon` |
| `PlasmaCore.Theme.mSize(font).height` | `Kirigami.Units.gridUnit` |
| `PlasmaCore.Units.roundToIconSize(value)` | `Kirigami.Units.iconSizes.roundedIconSize(value)` |

### Global context properties removed

Plasma 5 provided implicit `theme` and `units` context properties. These no longer exist in Plasma 6:

| Plasma 5 (implicit) | Plasma 6 (explicit) |
|---------------------|---------------------|
| `theme.defaultFont` | `Qt.application.font` |
| `theme.textColor` | `Kirigami.Theme.textColor` |
| `units.smallSpacing` | `Kirigami.Units.smallSpacing` |
| `units.largeSpacing` | `Kirigami.Units.largeSpacing` |
| `units.gridUnit` | `Kirigami.Units.gridUnit` |

Example fix:
```qml
// Plasma 5
font.family: theme.defaultFont.family
width: units.gridUnit * 2

// Plasma 6
font.family: Qt.application.font.family
width: Kirigami.Units.gridUnit * 2
```

### SVG theming moved to KSvg

SVG rendering components moved from PlasmaCore to a dedicated KSvg framework:

```qml
// Plasma 5
import org.kde.plasma.core 2.0 as PlasmaCore
PlasmaCore.SvgItem {
    svg: PlasmaCore.Svg { imagePath: "widgets/background" }
    colorGroup: PlasmaCore.Theme.NormalColorGroup
}

// Plasma 6
import org.kde.ksvg as KSvg
KSvg.SvgItem {
    imagePath: "widgets/background"  // simplified syntax
    // colorGroup removed - now automatic
}
```

### DataSource uses Plasma5Support

DataEngines are deprecated but available via the `Plasma5Support` compatibility library:

```qml
// Plasma 5
import org.kde.plasma.core 2.0 as PlasmaCore
PlasmaCore.DataSource { ... }

// Plasma 6
import org.kde.plasma.plasma5support as Plasma5Support
Plasma5Support.DataSource { ... }
```

**Note:** `PlasmaCore.Types.NoAlignment` becomes `Plasma5Support.Types.NoAlignment`.

The Plasma5Support README explicitly states DataEngines "should be migrated to QML imports" with no API stability guarantees through Plasma 6's lifecycle.

### PlasmaExtras changes

| Plasma 5 | Plasma 6 |
|----------|----------|
| `PlasmaExtras.ScrollArea` | `PlasmaComponents.ScrollView` |
| `PlasmaComponents.ListItem` (v2) | `PlasmaExtras.ListItem` |

## Qt 6 QML syntax changes

### Connections signal handlers

Qt 6 requires function syntax for signal handlers in Connections:

```qml
// Plasma 5 / Qt 5
Connections {
    target: someObject
    onSomeSignal: { doSomething() }
    onValueChanged: { handleChange(value) }
}

// Plasma 6 / Qt 6
Connections {
    target: someObject
    function onSomeSignal() { doSomething() }
    function onValueChanged(value) { handleChange(value) }
}
```

### QtQuick.Dialogs changes

The Dialogs module was restructured:

```qml
// Plasma 5
import QtQuick.Dialogs 1.3
Dialog {
    standardButtons: StandardButton.Ok
}
FontDialog {
    onAccepted: selectedFont = font
}

// Plasma 6
import QtQuick.Dialogs
Dialog {
    standardButtons: Dialog.Ok
}
FontDialog {
    onAccepted: myFont = selectedFont  // property name changed
}
```

## Metadata format changed from desktop to JSON

Plasma 6 **requires `metadata.json`** instead of `metadata.desktop`. Convert existing files using:

```bash
desktoptojson -s plasma-applet.desktop -i metadata.desktop
rm metadata.desktop
```

However, the automatic conversion produces incorrect output that requires manual fixes:

```json
{
    "KPlugin": {
        "Authors": [{"Name": "Developer", "Email": "dev@example.com"}],
        "Category": "System Information",
        "Description": "Widget description",
        "Icon": "battery",
        "Id": "com.example.mywidget",
        "License": "MIT",
        "Name": "My Widget",
        "Version": "1.0",
        "Website": "https://example.com"
    },
    "X-Plasma-API-Minimum-Version": "6.0",
    "KPackageStructure": "Plasma/Applet"
}
```

**Critical changes** from the conversion output:
- **Add** `"X-Plasma-API-Minimum-Version": "6.0"` at top level—without this, the widget won't appear in Plasma's UI
- **Replace** `"ServiceTypes": ["Plasma/Applet"]` (inside KPlugin) with `"KPackageStructure": "Plasma/Applet"` at top level
- **Remove** `X-Plasma-MainScript`—Plasma 6 always uses `ui/main.qml` as the entry point
- **Remove** `X-Plasma-API`—no longer used

## Context actions require declarative syntax

The action API changed from imperative registration to declarative definition. This is a **complete API break** with no backward compatibility:

```qml
// Plasma 5 - imperative registration
Component.onCompleted: {
    plasmoid.setAction("refresh", i18n("Refresh"), "view-refresh")
}
function action_refresh() {
    doRefresh()
}

// Plasma 6 - declarative definition
import org.kde.plasma.core as PlasmaCore

PlasmoidItem {
    Plasmoid.contextualActions: [
        PlasmaCore.Action {
            text: i18n("Refresh")
            icon.name: "view-refresh"
            enabled: root.canRefresh
            onTriggered: doRefresh()
        }
    ]
}
```

For triggering internal actions like the configure dialog:
```qml
// Plasma 5
plasmoid.action("configure").trigger()

// Plasma 6
Plasmoid.internalAction("configure").trigger()
```

## PlasmaComponents 3 API changes

When migrating from PlasmaComponents 2 to 3, watch for these property changes:

### ToolButton
```qml
// Plasma 5 (PlasmaComponents 2)
PlasmaComponents.ToolButton {
    iconSource: "window-pin"
    tooltip: i18n("Keep Open")
}

// Plasma 6 (PlasmaComponents 3)
PlasmaComponents.ToolButton {
    icon.name: "window-pin"
    PlasmaComponents.ToolTip {
        text: i18n("Keep Open")
    }
}
```

### Button icon
```qml
// Plasma 5
PlasmaComponents.Button {
    iconSource: "edit-copy"
}

// Plasma 6
PlasmaComponents.Button {
    icon.name: "edit-copy"
}
```

## Complete before-and-after migration example

This comprehensive example shows all major changes together:

**Plasma 5 main.qml:**
```qml
import QtQuick 2.15
import QtQuick.Layouts 1.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0

Item {
    id: root

    Plasmoid.toolTipMainText: "System Monitor"
    Plasmoid.toolTipSubText: "Click to expand"
    Plasmoid.icon: "utilities-system-monitor"
    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation

    Plasmoid.compactRepresentation: PlasmaCore.IconItem {
        source: plasmoid.icon
        MouseArea {
            anchors.fill: parent
            onClicked: plasmoid.expanded = !plasmoid.expanded
        }
    }

    Plasmoid.fullRepresentation: ColumnLayout {
        spacing: PlasmaCore.Units.smallSpacing

        PlasmaComponents.Label {
            text: "CPU Usage: 45%"
            color: PlasmaCore.Theme.textColor
        }

        PlasmaCore.SvgItem {
            svg: PlasmaCore.Svg { imagePath: "widgets/bar_meter_horizontal" }
            Layout.fillWidth: true
            Layout.preferredHeight: PlasmaCore.Units.gridUnit
        }
    }

    Component.onCompleted: {
        plasmoid.setAction("refresh", i18n("Refresh"), "view-refresh")
    }

    function action_refresh() {
        console.log("Refreshing...")
    }
}
```

**Plasma 6 main.qml:**
```qml
import QtQuick
import QtQuick.Layouts
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.plasmoid
import org.kde.kirigami as Kirigami
import org.kde.ksvg as KSvg

PlasmoidItem {
    id: root

    toolTipMainText: "System Monitor"
    toolTipSubText: "Click to expand"
    Plasmoid.icon: "utilities-system-monitor"
    preferredRepresentation: compactRepresentation

    compactRepresentation: Kirigami.Icon {
        source: Plasmoid.icon
        MouseArea {
            anchors.fill: parent
            onClicked: root.expanded = !root.expanded
        }
    }

    fullRepresentation: ColumnLayout {
        spacing: Kirigami.Units.smallSpacing

        PlasmaComponents.Label {
            text: "CPU Usage: 45%"
            color: Kirigami.Theme.textColor
        }

        KSvg.SvgItem {
            imagePath: "widgets/bar_meter_horizontal"
            Layout.fillWidth: true
            Layout.preferredHeight: Kirigami.Units.gridUnit
        }
    }

    Plasmoid.contextualActions: [
        PlasmaCore.Action {
            text: i18n("Refresh")
            icon.name: "view-refresh"
            onTriggered: console.log("Refreshing...")
        }
    ]
}
```

## Developer tools and testing workflow

**Testing commands** for Plasma 6 development:

```bash
# Test widget in standalone window
plasmoidviewer -a ./src

# Test as horizontal panel widget
plasmoidviewer -a ./src -l topedge -f horizontal

# Test with HiDPI scaling
QT_SCALE_FACTOR=2 plasmoidviewer -a ./src

# Install widget locally
kpackagetool6 -t Plasma/Applet --install ./src

# Upgrade existing installation
kpackagetool6 -t Plasma/Applet --upgrade ./src
```

**Clear QML cache** if changes don't seem to take effect:
```bash
rm -rf ~/.cache/plasmashell/qmlcache
```

**Zren's kpac script** automates much of the porting process. Available at `https://github.com/Zren/plasma-applet-lib/blob/master/kpac`, it handles import updates, metadata conversion, and packaging:

```bash
python3 ./kpac plasma6    # Apply Plasma 6 changes
python3 ./kpac build      # Create .plasmoid package
```

## Essential documentation and learning resources

The official **KDE Plasma Widget Porting Guide** at `develop.kde.org/docs/plasma/widget/porting_kf6/` provides the authoritative reference. The broader widget tutorial at `develop.kde.org/docs/plasma/widget/` covers Plasma 6 development from scratch.

For API details, `api.kde.org` hosts documentation for libplasma and all KDE Frameworks. The actual Plasma widgets in `/usr/share/plasma/plasmoids/` serve as reference implementations—`org.kde.plasma.analogclock` demonstrates simple configuration while `org.kde.plasma.digitalclock` shows DataSource integration.

Community examples include **plasma-applet-ambientnoise** on GitHub for a well-structured Plasma 6 widget, and Zren's various applets that were publicly ported with documented commits showing exact changes made.

## Migration checklist for existing plasmoids

A systematic approach prevents missing changes:

### Metadata
1. Convert `metadata.desktop` to `metadata.json` using desktoptojson
2. Add `"X-Plasma-API-Minimum-Version": "6.0"` to metadata
3. Replace `ServiceTypes` with top-level `KPackageStructure`
4. Remove `X-Plasma-MainScript` and `X-Plasma-API` entries

### Root element and properties
5. Change root element from `Item` to `PlasmoidItem`
6. Move tooltip/representation properties from `Plasmoid.` to direct properties on PlasmoidItem
7. Update `plasmoid.expanded` access in child components (use signals or direct parent reference)

### Imports
8. Remove all version numbers from QML imports
9. Update module paths:
   - `org.kde.plasma.calendar` → `org.kde.plasma.workspace.calendar`
   - `Qt.labs.settings` → `QtCore`
10. Remove `QtQuick.Controls 1.x` imports, migrate to v2

### Component migrations
11. Port PlasmaComponents 2 usages to PlasmaComponents 3
12. Replace `PlasmaCore.Theme` with `Kirigami.Theme`
13. Replace `PlasmaCore.Units` with `Kirigami.Units`
14. Replace `PlasmaCore.IconItem` with `Kirigami.Icon`
15. Convert `PlasmaCore.Svg/SvgItem/FrameSvgItem` to `KSvg` equivalents
16. Replace `PlasmaCore.DataSource` with `Plasma5Support.DataSource`
17. Replace `PlasmaExtras.ScrollArea` with `PlasmaComponents.ScrollView`
18. Update `QtGraphicalEffects` to `Qt5Compat.GraphicalEffects`

### Global context properties
19. Replace `theme.defaultFont` with `Qt.application.font`
20. Replace unqualified `units.*` with `Kirigami.Units.*`
21. Replace unqualified `theme.*` with `Kirigami.Theme.*`

### Actions
22. Port imperative actions to declarative `Plasmoid.contextualActions`
23. Update `plasmoid.action()` calls to `Plasmoid.internalAction()`

### Syntax updates
24. Update Connections handlers: `onSignal:` → `function onSignal()`
25. Update ToolButton: `iconSource` → `icon.name`, `tooltip` → ToolTip child
26. Update Dialog: `StandardButton.Ok` → `Dialog.Ok`

### Testing
27. Clear QML cache: `rm -rf ~/.cache/plasmashell/qmlcache`
28. Test thoroughly with `plasmoidviewer -a ./src`

## Conclusion

Porting plasmoids to Plasma 6 requires touching essentially every file in a widget package. The metadata format change, mandatory `PlasmoidItem` root, import namespace migrations, and declarative action API constitute breaking changes that prevent any automatic compatibility. However, the transformations follow consistent patterns—once you've ported one widget, subsequent migrations become straightforward find-and-replace operations.

The Plasma 5 DataEngine compatibility layer (`Plasma5Support`) provides a migration path but carries no stability guarantees. Widgets heavily dependent on DataEngines should plan for eventual migration to pure QML modules. Wayland-first design means X11-specific functionality requires portal-based alternatives.

The development experience itself improved: unversioned imports eliminate version mismatch bugs, the cleaner separation between `PlasmoidItem` and `Plasmoid` makes the API more intuitive, and declarative actions integrate naturally with QML's reactive paradigm. The upfront porting work enables cleaner, more maintainable widget code going forward.
