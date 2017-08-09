.. _scripts-setup:

################
setup.sh command
################

The :program:`setup.sh` command initializes an ``lsstsw`` installation in your :program:`bash` or :program:`zsh` shell.
For :program:`tcsh` shell users, a :program:`setup.csh` equivalent is available.

:program:`setup.sh` is intended to be sourced by every new shell that uses ``lsstsw``.

Basic usage is:

.. code-block:: bash

   source $lsstsw/bin/setup.sh

where ``$lsstsw`` is the path to the ``lsstsw`` directory.

You may ``setup.sh`` from your :file:`~/.bashrc` or :file:`~/.zshrc` login files.
