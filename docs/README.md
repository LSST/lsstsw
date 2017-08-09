# lsstsw documentation

This directory contains lsstsw's documentation source.
**You can find this documentation on the web at https://lsstsw.lsst.io.**

## Contributing workflow

1. Clone `https://github.com/lsst/lsstsw`.
2. Edit and commit documentation to reStructuredText files here using the [DM ticket branch workflow](https://developer.lsst.io/processes/workflow.html#ticket-branches).
3. Push the branch and find the edition at https://lsstsw.lsst.io/v.
4. Pull request the documentation change.
   Once it's approved and merged to master the main documentation at https://lsstsw.lsst.io will be updated.

## Building docs locally

1. Install requirements: ``pip install -r requirements.txt``.
2. Make the docs: ``make html``.
3. View the docs at: ``_build/html/index.html``.
