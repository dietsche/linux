#!/bin/bash
make CHECK="~/linux/smatch/smatch -p=kernel" C=1 bzImage modules

