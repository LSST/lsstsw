######
lsstsw
######

``lsstsw`` is a build tool for the LSST software stack.

``lsstsw`` is on GitHub at https://github.com/lsst/lsstsw/.

Quick start
===========

Clone ``lsstsw``:

.. code-block:: bash

   git clone https://github.com/lsst/lsstsw
   cd lsstsw

Deploy and build the LSST software stack:

.. code-block:: bash

   ./bin/deploy
   . bin/setup.sh
   rebuild lsst_distrib

Tag the build as current (get ``bNNNN`` from the previous console output):

.. code-block:: bash

   eups tags --clone bNNNN current

Set up the stack:

.. code-block:: bash

   eups setup lsst_distrib

Command reference
=================

.. toctree::

   scripts/deploy
   scripts/setup
   scripts/rebuild
