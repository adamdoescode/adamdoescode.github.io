'''
Tests for the webpage.
'''

from subprocess import run

def test_jekyll_build():
    '''Test that the Jekyll build succeeds.'''
    assert run(['jekyll', 'build']).returncode == 0
