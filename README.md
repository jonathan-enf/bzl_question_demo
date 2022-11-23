# bazel question demo

A repro case for a bzl question.  This is the most simplistic reproduction
case I can make for a much more sophisticated code generation flow that I'm
actually working on.

The [`defs.bzl`](defs.bzl) file here defines:

* a "datafile()" rule that wraps a datafile in a DataFileProvider, along with a list of dependencies.

* a "pygen()" rule that takes a DataFileProvider and produces the python source code for a library.

In my [`BUILD`](BUILD) file, I have:

* two `datafile` rules: `a-txt` and `b-txt`.  `a-txt` depends on `b-txt`.
* two `pygen` rules to produce `a.py` and `b.py`.  `a.py` contains `import b`.
* two manually-generated `py_library` rules, one for each generated python file.
  I have manually set library `b` as a dependency for library `a`.

The problem I'm trying to solve is: I'm trying to avoid having to list my
dependencies in two places (my provider's dependencies, and my `py_library`'s
dependencies).  What I really hope I can do is modify my `pygen` rule to not
only produce the source code, but also produce the PyInfo provider with the
correct set of dependencies, using only the information in my DataFileProvider.

Is this possible?  Can anyone propose a straightforward change to my model to
make this possible?

