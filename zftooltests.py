import sys
import unittest

sys.path.append('tests')
sys.path.append('plugin')
zftoolLoader = unittest.TestLoader()
suites = zftoolLoader.discover('tests', '*_tests.py')
result = unittest.TextTestRunner().run(suites)
if result.failures:
    exit(1)
elif result.errors:
    exit(2)
