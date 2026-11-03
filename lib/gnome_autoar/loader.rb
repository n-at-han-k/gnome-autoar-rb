# frozen_string_literal: true

# Released under the Apache License, Version 2.0.
# Copyright, 2026, by General Intelligence Systems.

module GnomeAutoar
  # Defines everything in the GnomeAutoar namespace from `GnomeAutoar-0.1.typelib`.
  #
  # Modelled on ruby-gnome's own loaders -- see
  # gtksourceview5/lib/gtksourceview5/loader.rb for one that has to call the
  # library's init function before anything works, and
  # libsecret/lib/libsecret/loader.rb for one that does not.
  #
  # The version string is the typelib's, which is not always the library's
  # release number and is not guessable: this one is "0.1", read off
  # `GnomeAutoar-0.1.typelib` rather than inferred.
  class Loader < GObjectIntrospection::Loader
    def load
      self.version = "0.1"
      super("GnomeAutoar")
    end

    private

    # A Ruby constant has to begin with an uppercase letter, and this typelib
    # has names that do not. GnomeAutoar-0.1 declares `7ZIP`, an archive format.
    # The default loader calls const_set regardless, which raises NameError
    # (or warns, for a lowercase name) and aborts the load partway through.
    #
    # ruby-gnome's own loaders override this hook for the same reason -- see
    # vte4 and webkit-gtk, which redirect `*_VERSION` constants into a Version
    # module. Here the values are kept in a hash rather than dropped, so
    # nothing in the typelib becomes unreachable.
    def load_constant_info(info)
      if /\A[A-Z]/.match?(info.name)
        super
      else
        GnomeAutoar::UNNAMEABLE_CONSTANTS[info.name] = info.value
      end
    end

    # `AutoarFormat` has a member named 7ZIP, and a Ruby constant cannot begin
    # with a digit, so the default `enum_module.const_set(name.upcase, value)`
    # raises NameError and aborts the whole load.
    #
    # The name is kept rather than invented around: SEVEN_ZIP or ZIP7 would be
    # a name this library does not use, and a caller reading the C
    # documentation would not find it. It goes in UNNAMEABLE_CONSTANTS under
    # "<Enum>::7ZIP", and the enum keeps every member that *can* be named.
    def load_enum_value(value_info, enum_module)
      if /\A[A-Za-z_]/.match?(value_info.name)
        super
      else
        key = "#{enum_module.name || "enum"}::#{value_info.name.upcase}"
        GnomeAutoar::UNNAMEABLE_CONSTANTS[key] = value_info.value
      end
    end

    def post_load(repository, namespace)
      require_libraries
    end

    def require_libraries
      # Nothing yet. Hand-written Ruby that improves on what the typelib gives
      # -- an each that yields, a to_s, a keyword-argument constructor -- goes
      # in files required from here, which is the convention ruby-gnome uses
      # for exactly that purpose.
    end
  end
end
