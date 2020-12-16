#!/bin/bash

# Weekday Widget for KDE
#
# @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
# @copyright 2020 Marcin Orlowski
# @license   http://www.opensource.org/licenses/mit-license.php MIT
# @link      https://github.com/MarcinOrlowski/weekday-plasmoid
#
# Updates plasmoid generated config files file based on current template,
# env vars and metadata.desktop file
#

set -euo pipefail

# shellcheck disable=SC2155
declare -r ROOT_DIR="$(realpath "$(dirname "$(realpath "${0}")")/..")"
source "${ROOT_DIR}/bin/common.sh"

function configurePlasmoid() {
	local -r meta="${ROOT_DIR}/src/contents/js/meta.js"
	echo "Populating ${meta}"
	dumpMeta > "${meta}"
}

configurePlasmoid
