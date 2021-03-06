#!/bin/bash

# Weekday Grid widget for KDE
#
# @author    Marcin Orlowski <mail (#) marcinOrlowski (.) com>
# @copyright 2020 Marcin Orlowski
# @license   http://www.opensource.org/licenses/mit-license.php MIT
# @link      https://github.com/MarcinOrlowski/weekday-plasmoid
#
# Packs plasmoid and installs/upgrades it locally, then restarts plasmashell.
#

set -euo pipefail

# shellcheck disable=SC2155
declare -r ROOT_DIR="$(realpath "$(dirname "$(realpath "${0}")")/..")"
source "${ROOT_DIR}/bin/common.sh"

function installPlasmoid() {
	local -r plasmoid_file_name="$(getPlasmoidFileName)"

	local -r tmp="$(mktemp -d "/tmp/${plasmoid_file_name}.XXXXXX")"
	local -r target_plasmoid_file="$(mktemp -u "/tmp/${plasmoid_file_name}.plasmoid.XXXXXX")"
	cp -a "${ROOT_DIR}"/src/* "${tmp}"

	dumpMeta > "${tmp}/contents/js/meta.js"

	pushd "${tmp}" > /dev/null
	zip  -r "${target_plasmoid_file}" -- *
	popd > /dev/null
	rm -rf "${tmp}"

	local -r user_home_dir="$(eval echo "~${USER}")"
	local -r pkg_name="$(getMetaTag "X-KDE-PluginInfo-Name")"
	if [[ -d "${user_home_dir}/.local/share/plasma/plasmoids/${pkg_name}" ]]; then
		kpackagetool5 --upgrade "${target_plasmoid_file}"
	else
		kpackagetool5 --install "${target_plasmoid_file}"
	fi

	kquitapp5 plasmashell
	kstart5 plasmashell

	rm -f "${target_plasmoid_file}"
}

installPlasmoid

