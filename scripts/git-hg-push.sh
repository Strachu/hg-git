#!/bin/bash

hg gimport
hg push
hg bookmark -f hg/default -r default
