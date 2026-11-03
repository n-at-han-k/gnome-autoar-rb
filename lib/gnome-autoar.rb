# frozen_string_literal: true

# Released under the Apache License, Version 2.0.
# Copyright, 2026, by General Intelligence Systems.

# `require "gnome-autoar"` — the gem's own name.
#
# This file exists because the gem name contains a dash and the library does
# not: the code lives in lib/gnome_autoar.rb, named for the GnomeAutoar namespace it
# defines. Without this, `require "gnome-autoar"` fails with
# `cannot load such file -- gnome-autoar`, which is how a port consuming this gem
# first discovered the problem.
#
# RubyGems also treats a dash as a directory separator, so gem_kit infers a
# require path of "gnome/autoar" from the gem name and warns
# "deprecations will not be detected" when nothing answers it. This file
# settles both.
require_relative "gnome_autoar"
