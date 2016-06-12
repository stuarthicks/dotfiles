#!/usr/bin/env python

from sys import stderr
from pip.commands.uninstall import UninstallCommand
from pip import get_installed_distributions

pip_uninstall = UninstallCommand()
options, args = pip_uninstall.parse_args([
    package.project_name
    for package in
    get_installed_distributions()
    if not package.location.endswith('dist-packages')
])

options.yes = True  # Don't confirm before uninstall
# set `options.require_venv` to True for virtualenv restriction

try:
    print pip_uninstall.run(options, args)
except OSError as e:
    if e.errno != 13:
        raise e
    print >> stderr, "You lack permissions to uninstall this package. Perhaps run with sudo? Exiting."
    exit(13)
# Plenty of other exceptions can be thrown, e.g.: `InstallationError`
# handle them if you want to.
