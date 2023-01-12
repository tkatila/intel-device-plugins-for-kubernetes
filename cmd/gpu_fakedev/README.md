# Fake (GPU) device file generator

Table of Contents
* [Introduction](#introduction)
* [Configuration](#configuration)
* [Potential improvements](#potential-improvements)
* [Related tools](#related-tools)

## Introduction

This is a tool for generating (large number of) fake device files for
k8s device scheduling scalability testing.  But it can also be used
just to test (GPU) device plugin functionality without having
corresponding device HW.

Its "intel-gpu-fakedev" container is intended to be run as first init
container in a device plugin pod, so that device plugin (and its NFD
labeler) see the fake (sysfs + devfs) files generated by the tool,
instead of real host sysfs and devfs content.

## Configuration

[Configs](configs/) subdirectory contains example JSON configuration
file(s) for the generator. Currently there's only one example JSON
file, but each new device variant adding feature(s) that have specific
support in device plugin, could have their own fake device config.

## Potential improvements

If support for mixed device environment is needed, tool can be updated
to use node / configuration file mapping.  Such mappings could be e.g.
in configuration files themselves as node name include / exlude lists,
and tool would use first configuration file matching the node it's
running on.  For now, one would need to use different pod / config
specs for different nodes to achieve that...

Currently JSON config file options and the generated files are tied to
what GPU plugin uses, but if needed, they could be changed to fake
also sysfs + devfs device files used by other plugins.

## Related tools

[fakedev-exporter](#https://github.com/intel/fakedev-exporter) project
can be used to schedule suitably configured fake workloads on the fake
devices, and to provide provide fake activity metrics for them to
Prometheus, that look like they were reported by real Prometheus
metric exporters for real workloads running on real devices.