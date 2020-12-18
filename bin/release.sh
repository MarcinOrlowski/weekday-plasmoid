#!/bin/bash

# Weekday Grid widget for KDE
#
# @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
# @copyright 2020 Marcin Orlowski
# @license   http://www.opensource.org/licenses/mit-license.php MIT
# @link      https://github.com/MarcinOrlowski/weekday-plasmoid
#
# Builds public release distributable plasmoid archive
#

set -euo pipefail

# shellcheck disable=SC2155
declare -r ROOT_DIR="$(realpath "$(dirname "$(realpath "${0}")")/..")"
source "${ROOT_DIR}/bin/common.sh"

function releasePlasmoid() {
	local -r plasmoid_file_name="$(getPlasmoidFileName)"
	local -r target_file="$(pwd)/${plasmoid_file_name}"
	if [[ -f "${target_file}" ]]; then
		echo "*** File already exists: ${target_file}"
		exit 1
	fi

	local -r tmp="$(mktemp -d "/tmp/${plasmoid_file_name}.XXXXXX")"
	cp -a "${ROOT_DIR}"/src/* "${tmp}"

	dumpMeta > "${tmp}/contents/js/meta.js"

	pushd "${tmp}" > /dev/null
	zip -q -r "${target_file}" -- *
	ls -ld "${target_file}"
	popd > /dev/null

	rm -rf "${tmp}"
}

releasePlasmoid
