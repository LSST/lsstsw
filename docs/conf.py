#!/usr/bin/env python
"""Sphinx configurations to build product documentation.
"""

from documenteer.sphinxconfig.stackconf import build_package_configs
from documenteer.sphinxconfig.utils import read_git_branch


_g = globals()
_g.update(build_package_configs(
    project_name='lsstsw',
    copyright='2017 Association of Universities for '
              'Research in Astronomy, Inc.',
    version=read_git_branch(),
    doxygen_xml_dirname=None))

intersphinx_mapping = {
    'python': ('http://docs.python.org/3/', None)
}
