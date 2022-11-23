# bazel question demo

A repro case for a bzl question.  This is the most simplistic reproduction
case I can make for a much more sophisticated code generation flow that I'm
actually working on.

The [`defs.bzl`](defs.bzl) file here contains:

  DataFileProvider: a provider with src and deps fields.
  datafile(): a rule to construct a DataFileProvider
  pygen(): a rule to convert a datafile to a python script

In the BUILD file, I create a pair of `datafile` declarations, with one
depending on the other.  `pygen` is used to create two python libraries,
one of which has an `import` statement that references the other.

The trouble is: I want to be able to automatically produce
the `py_library` rules shown at the bottom of the [BUILD](BUILD) file.
How do I use the `deps` attribute of the DataFileProvider to
automatically populate the `deps` attribute of the associated,
generated `py_library` rules?
