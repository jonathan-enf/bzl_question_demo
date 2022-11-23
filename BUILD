load("defs.bzl", "datafile", "pygen")

py_binary(
  name = "pygen",
  srcs = ["pygen.py"],
)

datafile(
  name = "b-txt",
  src = "b.txt",
)

datafile(
  name = "a-txt",
  src = "a.txt",
  deps = ["b"],
)

pygen(
  name = "a.py-gen",
  out = "a.py",
  src = ":a-txt",
)

pygen(
  name = "b.py-gen",
  out = "b.py",
  src = ":b-txt",
)

py_library(
  name = "b-py",
  srcs = [":b.py"],
)

# How do I write a bzl rule to automatically produce something equivalent
# to this py_library rule, but with the "deps" attribute derived from the
# dependencies listed in the DataFileProvider?
py_library(
  name = "a-py",
  srcs = [":a.py"],
  deps = [":b-py"],
)
