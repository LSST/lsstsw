.. _scripts-deploy:

##############
deploy command
##############

Synopsis
========

**deploy** [-3] [-b] [-h]

Description
===========

:program:`deploy` installs ``lsstsw``, setting up: EUPS, miniconda Python (2.7 *or* 3.5), and Git LFS.
:program:`deploy` should only be run once.

Example: default lsstsw set up
------------------------------

.. code-block:: bash

   git clone https://github.com/lsst/lsstsw
   cd lsstsw
   ./bin/deploy

Example: Python 3 lsstsw set up
-------------------------------

.. code-block:: bash

   git clone https://github.com/lsst/lsstsw
   cd lsstsw
   ./bin/deploy -3

Options
=======

-3
   Use Python 3, via miniconda. Otherwise, the default is Python 2.7.

-b
   Use bleeding edge Conda packages.

-h
   Show a help message.
