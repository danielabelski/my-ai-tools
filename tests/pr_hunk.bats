#!/usr/bin/env bats
# Tests for Hunk integration

load helpers

LIB_INSTALL="$REPO_ROOT/lib/install.sh"
CLI_SH="$REPO_ROOT/cli.sh"
GENERATE_SH="$REPO_ROOT/generate.sh"
CONFIG="$REPO_ROOT/configs/hunk/config.toml"
README="$REPO_ROOT/README.md"

@test "Hunk config exists and is valid TOML" {
	[ -f "$CONFIG" ]
	run bash -c 'source "$1/lib/common.sh"; validate_config "$1/configs/hunk/config.toml"' _ "$REPO_ROOT"
	[ "$status" -eq 0 ]
}

@test "Hunk config enables the built-in Kanagawa theme and agent notes" {
	run grep -F 'theme = "kanagawa-wave"' "$CONFIG"
	[ "$status" -eq 0 ]
	run grep -F 'agent_notes = true' "$CONFIG"
	[ "$status" -eq 0 ]
}

@test "Hunk uses the official hunkdiff npm package" {
	run grep -F 'install_npm_tool "Hunk" "hunk" "hunkdiff"' "$LIB_INSTALL"
	[ "$status" -eq 0 ]
	run grep -F '"hunk:install_hunk"' "$CLI_SH"
	[ "$status" -eq 0 ]
}

@test "Hunk config install honors XDG_CONFIG_HOME" {
	run bash -c '
		set -e
		temp_home=$(mktemp -d)
		temp_xdg=$(mktemp -d)
		trap '\''rm -rf "$temp_home" "$temp_xdg"'\'' EXIT
		export HOME="$temp_home" XDG_CONFIG_HOME="$temp_xdg"
		export DRY_RUN=false YES_TO_ALL=false VERBOSE=false
		mkdir -p "$XDG_CONFIG_HOME/hunk"
		source "$1/cli.sh"
		copy_hunk_configs >/dev/null
		cmp "$1/configs/hunk/config.toml" "$XDG_CONFIG_HOME/hunk/config.toml"
	' _ "$REPO_ROOT"
	[ "$status" -eq 0 ]
}

@test "Hunk config is backed up and reverse-synced" {
	run grep -F '${XDG_CONFIG_HOME:-$HOME/.config}/hunk' "$CLI_SH"
	[ "$status" -eq 0 ]
	run grep -F 'generate_hunk_configs' "$GENERATE_SH"
	[ "$status" -eq 0 ]
	run grep -F 'copy_single "$hunk_dir/config.toml" "$SCRIPT_DIR/configs/hunk/config.toml"' "$GENERATE_SH"
	[ "$status" -eq 0 ]
}

@test "README documents Hunk installation, config, and review usage" {
	run grep -F 'npm install --global hunkdiff' "$README"
	[ "$status" -eq 0 ]
	run grep -F 'configs/hunk/config.toml' "$README"
	[ "$status" -eq 0 ]
	run grep -F 'hunk diff --watch' "$README"
	[ "$status" -eq 0 ]
	run grep -F 'https://www.hunk.dev/docs/reference/config' "$README"
	[ "$status" -eq 0 ]
}

@test "Hunk support has a changeset" {
	[ -f "$REPO_ROOT/.changeset/add-hunk-support.md" ]
}
