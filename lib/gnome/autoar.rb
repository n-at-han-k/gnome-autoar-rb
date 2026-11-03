# frozen_string_literal: true

# Released under the Apache License, Version 2.0.
# Copyright, 2026, by General Intelligence Systems.

# RubyGems treats a dash in a gem name as a directory separator, so the
# conventional entry point for `gnome-autoar` is `gnome/autoar`. gem_kit
# infers that and requires it to find this gem's deprecations.
require_relative "../gnome_autoar"
