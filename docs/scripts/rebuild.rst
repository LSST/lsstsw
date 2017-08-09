.. _scripts-rebuild:

###############
rebuild command
###############

Synopsis
========

**rebuild** [-p] [-n] [-u] [-r <*ref*> [-r <*ref2*> [...]]] [-t <*eupstag*>] [*product1* [*product2* [...]]]

Description
===========

:program:`rebuild` clones and builds EUPS products, including their dependencies.

To build a single product from ``master``:

.. code-block:: bash

   rebuild lsst_distrib

To build multiple products:

.. code-block:: bash

   rebuild lsst_distrib qserv_distrib

Building from branches
----------------------

:program:`lsstsw` enables you to clone and build development branches.

To build ``lsst_distrb``, but using the Git branch ``my-feature`` when it's available in a package:

.. code-block:: bash

   rebuild -r my-feature lsst_distrib

Multiple ticket branches across multiple products can be built in order of priority:

.. code-block:: bash

   rebuild -r feature-1 -r feature-2 lsst_distrib

In this example, a ``feature-1`` branch will be used in any product's Git repository.
A ``feature-2`` branch will be used secondarily in repositories where ``feature-1`` doesn't exist.
Finally, ``lsstsw`` falls back to using the ``master`` branch for repositories that lack both ``feature-1`` and ``feature-2``.

Options
=======

-p
   Prep only.

-n
   No fetch.

-u
   Update.

-r <git ref>
   Rebuild using the Git ref.
   Multiple ``-r`` arguments can be given, in order or priority.

-t
   Tag.
